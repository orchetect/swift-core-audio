//
//  AudioBooleanControl.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

/// Represents an individual audio boolean control.
///
/// The `AudioBooleanControl` class is a subclass of the `AudioControl` class and has
/// the same scope and element structure.
public struct AudioBooleanControl {
    nonisolated
    public let id: ID
    
    nonisolated
    public init(id: ID) {
        self.id = id
    }
}

extension AudioBooleanControl: Equatable { }

extension AudioBooleanControl: Hashable { }

extension AudioBooleanControl: Sendable { }

// MARK: - CustomStringConvertible

extension AudioBooleanControl: CustomStringConvertible {
    public var description: String {
        "AudioBooleanControl(\(id))"
    }
}

#endif
