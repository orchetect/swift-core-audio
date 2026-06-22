//
//  AudioSelectorControl.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

/// Represents an individual audio selector control.
///
/// The `AudioSelectorControl` class is a subclass of the `AudioControl` class and has the
/// same scope and element structure.
public struct AudioSelectorControl {
    nonisolated
    public let id: ID

    nonisolated
    public init(id: ID) {
        self.id = id
    }
}

extension AudioSelectorControl: Equatable { }

extension AudioSelectorControl: Hashable { }

extension AudioSelectorControl: Sendable { }

// MARK: - CustomStringConvertible

extension AudioSelectorControl: CustomStringConvertible {
    public var description: String {
        "AudioSelectorControl(\(id))"
    }
}

#endif
