//
//  AudioDeviceProperties+Convenience.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
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
    nonisolated
    public func channelCount(for direction: AudioStream.Direction) throws(SwiftCoreAudioError) -> Int {
        let audioStreams = try streams(for: direction)
        var count = 0
        for stream in audioStreams {
            // this may be naïve but it seems to work
            count += try Int(stream.virtualFormat.channelsPerFrame)
        }
        return count
    }
    
    /// Returns the total channel count of channels for all streams for both directions.
    /// This method is more efficient than calling ``channelCount(for:)`` twice (for each direction).
    nonisolated
    public var channelCounts: (inputs: Int, outputs: Int) {
        get throws(SwiftCoreAudioError) {
            let audioStreams = try streams
            var inputCount: Int = 0
            var outputCount: Int = 0
            
            for audioStream in audioStreams {
                let direction = try audioStream.direction
                let channels = try audioStream.channelCount
                
                switch direction {
                case .input:
                    inputCount += channels
                case .output:
                    outputCount += channels
                }
            }
            
            return (inputs: inputCount, outputs: outputCount)
        }
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
        of direction: AudioStream.Direction,
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
    nonisolated
    public func streams(for direction: AudioStream.Direction) throws(SwiftCoreAudioError) ->[AudioStream] {
        var filteredStreams: [AudioStream] = []
        for stream in try streams {
            if try stream.direction == direction { filteredStreams.append(stream) }
        }
        return filteredStreams
    }
    
    /// Returns a boolean value indicating whether the device has at least one stream for the given
    /// direction.
    nonisolated
    public func hasStreams(for direction: AudioStream.Direction) throws(SwiftCoreAudioError) -> Bool {
        let audioStreams = try streams
        
        // if any stream is the specified direction return true
        for audioStream in audioStreams {
            if try audioStream.direction == direction { return true }
        }
        
        return false
    }
}

#endif
