//
//  AudioProperty+Wildcard.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

// swiftformat:disable wrap wrapArguments
// swiftformat:options --wrap-collections preserve

// MARK: Scope & Element

extension AudioProperty where SelectorConstant == AudioWildcardPropertySelectorConstant { }

// MARK: - CoreAudio/AudioHardwareBase.h

extension AudioProperty where SelectorConstant == AudioWildcardPropertySelectorConstant, Qualifier == Never, Value == Never {
    nonisolated
    public static var wildcard: Self {
        AudioProperty(selectorConstant: .wildcard, scope: .wildcard, element: .wildcard)
    }
}

#endif
