//
//  AudioPropertyProtocol.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

/// Interface to allow converting an ``AudioProperty`` to a Core Audio property address.
public protocol AudioPropertyProtocol {
    associatedtype Qualifier
    associatedtype Value

    /// Returns a new `AudioObjectPropertyAddress` instance constructed from the property's
    /// selector, scope, and element.
    var address: AudioObjectPropertyAddress { get }
}

#endif
