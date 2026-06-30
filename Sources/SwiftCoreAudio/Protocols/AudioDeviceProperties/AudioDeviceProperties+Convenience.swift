//
//  AudioDeviceProperties+Convenience.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

// MARK: - Properties

extension AudioDeviceProperties {
    /// Returns `true` if the device is present in the devices currently available to the system.
    ///
    /// > Note: Avoid calling this method repeatedly for each element in a collection of devices.
    /// > Instead, get the value of `AudioSystem.shared.devices` once and check for the presence of
    /// > each device in the returned array.
    nonisolated
    public var isPresent: Bool {
        // TODO: there may be a direct Core Audio call that can do this faster than this method...
        guard let ids = try? AudioSystem.shared.devices.map(\.id.rawValue) else { return false }
        return ids.contains(id.rawValue)
    }
}

// MARK: - Channels

extension AudioDeviceProperties {
    /// Returns the total channel count of channels for all streams of the given direction.
    ///
    /// - Parameters:
    ///   - direction: Input or output audio stream direction.
    ///   - streamLookupErrorHandler: Optionally supply an error handler that will be called for any streams
    ///     that fail lookup.
    ///     If this closure is `nil`, failures are silently ignored but will still be logged.
    /// - Throws: Throws an error if stream enumeration fails. Individual failures on a per-device basis are
    ///   passed to the `streamLookupErrorHandler` closure and do not cause this method itself to throw.
    nonisolated
    public func channelCount(
        for direction: AudioStream.Direction,
        streamLookupErrorHandler: ((_ stream: AudioStream, _ error: SwiftCoreAudioError) -> ())? = nil
    ) throws(SwiftCoreAudioError) -> Int {
        let audioStreams = try streams(for: direction, directionLookupErrorHandler: streamLookupErrorHandler)
        var count = 0
        for stream in audioStreams {
            do throws(SwiftCoreAudioError) {
                // this may be naïve but it seems to work
                count += try Int(stream.channelCount)
            } catch {
                if let streamLookupErrorHandler {
                    streamLookupErrorHandler(stream, error)
                } else {
                    CoreAudioLogging.log(.error, "Error looking up channel count for \(direction) audio stream with ID \(stream.id): \(error)")
                }
            }
        }
        return count
    }

    /// Returns the total channel count of channels for all streams for both directions.
    /// This method is more efficient than calling ``channelCount(for:)`` twice (for each direction).
    ///
    /// - Parameters:
    ///   - streamLookupErrorHandler: Optionally supply an error handler that will be called for any streams
    ///     that fail lookup.
    ///     If this closure is `nil`, failures are silently ignored but will still be logged.
    /// - Throws: Throws an error if stream enumeration fails. Individual failures on a per-device basis are
    ///   passed to the `streamLookupErrorHandler` closure and do not cause this method itself to throw.
    nonisolated
    public func channelCounts(
        streamLookupErrorHandler: ((_ stream: AudioStream, _ error: SwiftCoreAudioError) -> ())? = nil
    ) throws(SwiftCoreAudioError) -> (inputs: Int, outputs: Int) {
        var inputCount: Int = 0
        var outputCount: Int = 0

        for stream in try streams {
            do throws(SwiftCoreAudioError) {
                let direction = try stream.direction
                let channels = try stream.channelCount

                switch direction {
                case .input:
                    inputCount += channels
                case .output:
                    outputCount += channels
                }
            } catch {
                if let streamLookupErrorHandler {
                    streamLookupErrorHandler(stream, error)
                } else {
                    CoreAudioLogging.log(.error, "Error looking up channel counts for audio stream with ID \(stream.id): \(error)")
                }
            }
        }

        return (inputs: inputCount, outputs: outputCount)
    }

    /// Returns the channel name if one is assigned for the given channel number (1-based).
    ///
    /// Note that users are able to manually assign custom channel names to channels in Audio MIDI Setup.
    /// If no name is assigned, `nil` is returned. If the user has assigned a channel name, the name will be returned.
    ///
    /// Channel numbers are 1:1 with user-facing channel numbers (starting from channel 1, then 2,
    /// etc...), not to be confused with channel index (zero-based).
    nonisolated
    public func channelName(
        forChannelNumber channelNumber: Int, // 1-based
        of direction: AudioStream.Direction
    ) throws(SwiftCoreAudioError) -> String? {
        let property: DeviceProperty = .channelName(forChannelNumber: channelNumber, of: direction)
        let cfString: CFString? = try getPropertyOptionalObject(address: property.address, qualifier: .none)
        let string = cfString as String?

        // if a channel name is not assigned, or if the channel index does not exist, Core Audio gives us an empty string.
        // we'll convert an empty string to a `nil` return value.
        if string?.isEmpty == true { return nil }

        return string
    }
}

// MARK: - Streams

extension AudioDeviceProperties {
    /// Returns all streams for the audio direction.
    ///
    /// - Parameters:
    ///   - direction: Input or output audio stream direction.
    ///   - streamLookupErrorHandler: Optionally supply an error handler that will be called for any stream
    ///     directions that fail lookup.
    ///     If this closure is `nil`, failures are silently ignored but will still be logged.
    /// - Throws: Throws an error if stream enumeration fails. Individual failures on a per-stream basis are
    ///   passed to the `directionLookupErrorHandler` closure and do not cause this method itself to throw.
    nonisolated
    public func streams(
        for direction: AudioStream.Direction,
        directionLookupErrorHandler: ((_ stream: AudioStream, _ error: SwiftCoreAudioError) -> ())? = nil
    ) throws(SwiftCoreAudioError) -> [AudioStream] {
        var filteredStreams: [AudioStream] = []
        for stream in try streams {
            do throws(SwiftCoreAudioError) {
                if try stream.direction == direction { filteredStreams.append(stream) }
            } catch {
                if let directionLookupErrorHandler {
                    directionLookupErrorHandler(stream, error)
                } else {
                    CoreAudioLogging.log(.error, "Error looking up direction for \(direction) audio stream with ID \(stream.id): \(error)")
                }
            }
        }
        return filteredStreams
    }

    /// Returns a boolean value indicating whether the device has at least one stream for the given
    /// direction.
    ///
    /// - Parameters:
    ///   - direction: Input or output audio stream direction.
    ///   - streamLookupErrorHandler: Optionally supply an error handler that will be called for any stream
    ///     directions that fail lookup.
    ///     If this closure is `nil`, failures are silently ignored but will still be logged.
    /// - Throws: Throws an error if stream enumeration fails. Individual failures on a per-stream basis are
    ///   passed to the `directionLookupErrorHandler` closure and do not cause this method itself to throw.
    nonisolated
    public func hasStreams(
        for direction: AudioStream.Direction,
        directionLookupErrorHandler: ((_ stream: AudioStream, _ error: SwiftCoreAudioError) -> ())? = nil
    ) throws(SwiftCoreAudioError) -> Bool {
        for stream in try streams {
            do throws(SwiftCoreAudioError) {
                if try stream.direction == direction { return true }
            } catch {
                if let directionLookupErrorHandler {
                    directionLookupErrorHandler(stream, error)
                } else {
                    CoreAudioLogging.log(.error, "Error looking up direction for \(direction) audio stream with ID \(stream.id): \(error)")
                }
            }
        }

        return false
    }
}

#endif
