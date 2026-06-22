//
//  AudioStereoPanControl.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

/// Represents an individual audio stereo pan control.
///
/// The `AudioStereoPanControl` class is a subclass of the `AudioControl` class and has the
/// same scope and element structure.
public struct AudioStereoPanControl {
    nonisolated
    public let id: ID

    nonisolated
    public init(id: ID) {
        self.id = id
    }
}

extension AudioStereoPanControl: Equatable { }

extension AudioStereoPanControl: Hashable { }

extension AudioStereoPanControl: Sendable { }

// MARK: - CustomStringConvertible

extension AudioStereoPanControl: CustomStringConvertible {
    public var description: String {
        "AudioStereoPanControl(\(id))"
    }
}

#endif
