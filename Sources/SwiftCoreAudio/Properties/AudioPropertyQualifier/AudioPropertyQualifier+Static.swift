//
//  AudioPropertyQualifier+Static.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import Foundation

// MARK: - Static Constructors

extension AudioPropertyQualifier where T == Never {
    /// No qualifier value (`nil`).
    nonisolated
    public static var none: Self {
        AudioPropertyQualifier()
    }
}

extension AudioPropertyQualifier where T == CFString {
    /// `CFString` qualifier value.
    nonisolated
    public static func cfString(_ string: String) -> Self {
        AudioPropertyQualifier(initialValue: string as CFString)
    }
}

extension AudioPropertyQualifier where T == Int32 {
    /// `Int32` qualifier value.
    nonisolated
    public static func int32(_ value: Int32) -> Self {
        AudioPropertyQualifier(initialValue: value)
    }
}

extension AudioPropertyQualifier where T == UInt32 {
    /// `UInt32` qualifier value.
    nonisolated
    public static func uInt32(_ value: UInt32) -> Self {
        AudioPropertyQualifier(initialValue: value)
    }
}

#endif
