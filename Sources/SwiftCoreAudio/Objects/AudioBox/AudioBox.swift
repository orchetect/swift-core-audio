//
//  AudioBox.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

/// Represents an individual audio box.
///
/// An `AudioBox` is a container for other objects (typically `AudioDevice` objects). An
/// `AudioBox` publishes identifying information about itself and can be enabled or disabled.
/// A box's contents are only available to the system when the box is enabled.
///
/// The `AudioBox` class is a subclass of the `AudioObject` class.
///
/// The class has just the global scope (`kAudioObjectPropertyScopeGlobal`) and only a main element.
public struct AudioBox {
    nonisolated
    public let id: ID

    nonisolated
    public init(id: ID) {
        self.id = id
    }
}

extension AudioBox: Equatable { }

extension AudioBox: Hashable { }

extension AudioBox: Sendable { }

// MARK: - CustomStringConvertible

extension AudioBox: CustomStringConvertible {
    public var description: String {
        "AudioBox(\(id))"
    }
}

#endif
