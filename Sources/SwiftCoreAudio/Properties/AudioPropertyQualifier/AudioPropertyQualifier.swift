//
//  AudioPropertyQualifier.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import Foundation

/// Qualifier value provided to a Core Audio object property method.
public struct AudioPropertyQualifier<T> {
    nonisolated
    let value: T!

    nonisolated
    let size: UInt32

    /// Initialize as `nil` (no qualifier).
    nonisolated
    public init() where T == Never {
        value = nil
        size = 0
    }

    nonisolated
    public init(initialValue value: T) {
        self.value = value
        size = UInt32(MemoryLayout<T>.stride)
    }

    nonisolated
    public init(initialValue value: T, size: UInt32) {
        self.value = value
        self.size = size
    }

    nonisolated
    public init<S>(initialValue value: T, sizeOf typeForSize: S.Type) {
        self.value = value
        size = UInt32(MemoryLayout<S>.stride)
    }
}

// MARK: - Methods

extension AudioPropertyQualifier {
    /// Provides a closure with a scoped pointer to access the value's memory.
    public func withPointerToValue<V, E: Error>(_ block: (UnsafePointer<T>?) throws(E) -> V) throws(E) -> V {
        switch T.self {
        case is Never.Type:
            try block(nil)
        default:
            try withUnsafePointer(to: value!) { valuePtr throws(E) in
                try block(valuePtr)
            }
        }
    }
}

#endif
