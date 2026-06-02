//
//  AudioObjectPropertyAddress+Equatable.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

// Provide a backwards-compatible method to check equality between two instances.
// The `==` operator provided by Core Audio requires macOS 15+.
extension AudioObjectPropertyAddress {
    /// Returns `true` if both addresses are equal.
    public func isEqual(to other: AudioObjectPropertyAddress) -> Bool {
        mSelector == other.mSelector
            && mScope == other.mScope
            && mElement == other.mElement
    }
}

#endif
