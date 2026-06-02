//
//  AudioSubDevice.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

/// Represents an individual audio subdevice.
///
/// A subdevice represents the relationship that an existing device has to a specific aggregate
/// that is has been added to. The device's properties are provided by its `AudioDevice` implementation,
/// and the relationship it has to its containing aggregate device is provided by its `AudioSubDevice`
/// implementation.
///
/// The `AudioSubDevice` class is a subclass of `AudioDevice` class and has the same
/// scope and element structure. However, `AudioSubDevice` objects do not implement an
/// IO path of their own and as such do not implement any `AudioDevice` properties
/// associated with the IO path. They also don't have any streams.
public struct AudioSubDevice {
    nonisolated
    public let id: ID
    
    nonisolated
    public init(id: ID) {
        self.id = id
    }
}

extension AudioSubDevice: Equatable { }

extension AudioSubDevice: Hashable { }

extension AudioSubDevice: Sendable { }

// MARK: - CustomStringConvertible

extension AudioSubDevice: CustomStringConvertible {
    public var description: String {
        "AudioSubDevice(\(id))"
    }
}

// MARK: - Type Erasure

extension AudioSubDevice {
    /// Returns self wrapped in an ``AnyAudioDevice`` case.
    nonisolated
    public var asAnyAudioDevice: AnyAudioDevice? {
        get throws(SwiftCoreAudioError) {
            // `id` of a subdevice is shared with the id of the device or aggregate it came from,
            // so `AnyAudioDevice` will cast it appropriately.
            AnyAudioDevice(id: id.rawValue)
        }
    }
}

#endif
