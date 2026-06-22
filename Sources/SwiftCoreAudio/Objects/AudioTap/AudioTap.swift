//
//  AudioTap.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

/// Represents an individual audio tap.
///
/// An audio tap can capture outgoing audio from a process or group of processes, and be used as
/// an input stream source in an aggregate device.
///
/// The `AudioTap` class is a subclass of the `AudioObject` class.
///
/// The class has just the global scope (`kAudioObjectPropertyScopeGlobal`) and only a main element.
///
/// > Note:
/// >
/// > Creating or destroying audio taps are not available on Mac Catalyst.
/// > Tap-related types and objects are still available on the platform for multi-platform compilation
/// > compatibility.
public struct AudioTap {
    nonisolated
    public let id: ID

    nonisolated
    public init(id: ID) {
        self.id = id
    }
}

extension AudioTap: Equatable { }

extension AudioTap: Hashable { }

extension AudioTap: Sendable { }

// MARK: - CustomStringConvertible

extension AudioTap: CustomStringConvertible {
    public var description: String {
        "AudioTap(\(id))"
    }
}

#endif
