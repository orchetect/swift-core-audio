//
//  AudioLevelControl.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

/// Represents an individual audio level control.
///
/// The `AudioLevelControl` class is a subclass of the `AudioControl` class and has the
/// same scope and element structure.
public struct AudioLevelControl {
    nonisolated
    public let id: ID
    
    nonisolated
    public init(id: ID) {
        self.id = id
    }
}

extension AudioLevelControl: Equatable { }

extension AudioLevelControl: Hashable { }

extension AudioLevelControl: Sendable { }

// MARK: - CustomStringConvertible

extension AudioLevelControl: CustomStringConvertible {
    public var description: String {
        "AudioLevelControl(\(id))"
    }
}

#endif
