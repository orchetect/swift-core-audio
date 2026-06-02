//
//  AudioTransportManager.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

/// Represents an individual audio transport manager.
///
/// The `AudioTransportManager` class is a subclass of the `AudioPlugIn` class.
///
/// The class has just the global scope (`kAudioObjectPropertyScopeGlobal`) and only a main element.
public struct AudioTransportManager {
    nonisolated
    public let id: ID
    
    nonisolated
    public init(id: ID) {
        self.id = id
    }
}

extension AudioTransportManager: Equatable { }

extension AudioTransportManager: Hashable { }

extension AudioTransportManager: Sendable { }

// MARK: - CustomStringConvertible

extension AudioTransportManager: CustomStringConvertible {
    public var description: String {
        "AudioTransportManager(\(id))"
    }
}

#endif
