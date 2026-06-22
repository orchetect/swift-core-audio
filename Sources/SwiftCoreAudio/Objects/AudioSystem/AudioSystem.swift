//
//  AudioSystem.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

/// The top-level audio system object.
/// All other audio objects derive from this object.
///
/// The audio objects in the HAL are arranged in a containment hierarchy.
/// The root of the hierarchy is the one and only instance of the system object.
/// The properties of this object describe the process global settings such as the various default devices.
/// The system object also contains all the devices that are available.
///
/// The `AudioSystemObject` class is a subclass of the `AudioObject` class.
///
/// Note that there is only ever one instance of the AudioSystemObject class and it is available via
/// the `AudioObjectID` `kAudioObjectSystemObject` (represented by the ``id`` property of ``AudioSystem``).
///
/// The class has just the global scope (`kAudioObjectPropertyScopeGlobal`) and only a main element.
public struct AudioSystem {
    nonisolated
    public static let shared = AudioSystem()

    nonisolated
    private init() { }
}

extension AudioSystem: Equatable { }

extension AudioSystem: Hashable { }

extension AudioSystem: Sendable { }

// MARK: - CustomStringConvertible

extension AudioSystem: CustomStringConvertible {
    public var description: String {
        "AudioSystem"
    }
}

#endif
