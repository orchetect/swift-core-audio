//
//  AudioPropertyConstant.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import Foundation

/// Core Audio `kAudio*` constants.
public protocol AudioPropertyConstant: Equatable, Hashable, RawRepresentable, Sendable, CustomStringConvertible
where RawValue == FourCharCode /* a.k.a. UInt32 */
{ }

#endif
