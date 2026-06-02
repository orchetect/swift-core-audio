//
//  AudioPlugIn.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

/// Represents an individual audio plug-in.
///
/// The `AudioPlugIn` class is a subclass of the `AudioObject` class.
///
/// The class has just the global scope (`kAudioObjectPropertyScopeGlobal`) and only a main element.
public struct AudioPlugIn {
    nonisolated
    public let id: ID

    nonisolated
    public init(id: ID) {
        self.id = id
    }
}

extension AudioPlugIn: Equatable { }

extension AudioPlugIn: Hashable { }

extension AudioPlugIn: Sendable { }

// MARK: - CustomStringConvertible

extension AudioPlugIn: CustomStringConvertible {
    public var description: String {
        "AudioPlugIn(\(id))"
    }
}

#endif
