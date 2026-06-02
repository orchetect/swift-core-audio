//
//  AudioProcess.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

/// Represents an individual audio process.
///
/// Audio processes contain information about a client process connected to the HAL.
public struct AudioProcess {
    nonisolated
    public let id: ID

    nonisolated
    public init(id: ID) {
        self.id = id
    }
}

extension AudioProcess: Equatable { }

extension AudioProcess: Hashable { }

extension AudioProcess: Sendable { }

// MARK: - CustomStringConvertible

extension AudioProcess: CustomStringConvertible {
    public var description: String {
        "AudioProcess(\(id))"
    }
}

#endif
