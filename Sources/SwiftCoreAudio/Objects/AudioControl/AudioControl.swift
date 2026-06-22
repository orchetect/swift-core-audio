//
//  AudioControl.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

/// Represents an individual audio control.
///
/// The `AudioControl` class is a subclass of the `AudioObject` class.
///
/// The class has just the global scope (`kAudioObjectPropertyScopeGlobal`) and only a main element.
public struct AudioControl {
    nonisolated
    public let id: ID

    nonisolated
    public init(id: ID) {
        self.id = id
    }
}

extension AudioControl: Equatable { }

extension AudioControl: Hashable { }

extension AudioControl: Sendable { }

// MARK: - CustomStringConvertible

extension AudioControl: CustomStringConvertible {
    public var description: String {
        "AudioControl(\(id))"
    }
}

#endif
