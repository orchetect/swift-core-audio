//
//  AudioObjectSnapshot PropertyKey.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

extension AudioObjectSnapshot {
    public protocol PropertyKey: Equatable, Hashable, CaseIterable, RawRepresentable, Codable, CustomStringConvertible, Sendable
    where RawValue == String {
        /// Returns the property key as an``AudioObjectSnapshot/AnyPropertyKey`` instance.
        var asAnyPropertyKey: AudioObjectSnapshot.AnyPropertyKey { get }
    }
}

extension AudioObjectSnapshot.PropertyKey /* : CustomStringConvertible */ {
    public var description: String {
        rawValue
    }
}

extension AudioObjectSnapshot.PropertyKey {
    public static var allCasesAsAnyPropertyKeys: [AudioObjectSnapshot.AnyPropertyKey] {
        allCases.map(\.asAnyPropertyKey)
    }
}
#endif
