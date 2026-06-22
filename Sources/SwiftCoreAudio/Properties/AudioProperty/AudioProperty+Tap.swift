//
//  AudioProperty+Tap.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

// swiftformat:disable wrap wrapArguments
// swiftformat:options --wrap-collections preserve

// MARK: Scope & Element

extension AudioProperty where SelectorConstant == AudioTapPropertySelectorConstant {
    nonisolated
    private static var scope: any AudioPropertyScopeConstant {
        .object(.global)
    }

    nonisolated
    private static var element: any AudioPropertyElementConstant {
        .object(.main)
    }
}

// MARK: CoreAudio/AudioHardware.h

extension AudioProperty where SelectorConstant == AudioTapPropertySelectorConstant, Qualifier == Never, Value == String {
    nonisolated
    public static var uid: Self {
        AudioProperty(selectorConstant: .uid, scope: scope, element: element)
    }
}

@available(macOS 12.0, macCatalyst 15.0, *)
extension AudioProperty where SelectorConstant == AudioTapPropertySelectorConstant, Qualifier == Never, Value == CATapDescription {
    nonisolated
    public static var description: Self {
        AudioProperty(selectorConstant: .description, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioTapPropertySelectorConstant, Qualifier == Never, Value == AudioStreamBasicDescription {
    nonisolated
    public static var format: Self {
        AudioProperty(selectorConstant: .uid, scope: scope, element: element)
    }
}

#endif
