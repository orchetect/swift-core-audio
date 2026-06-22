//
//  AudioProperty+SubTap.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

// swiftformat:disable wrap wrapArguments
// swiftformat:options --wrap-collections preserve

// MARK: Scope & Element

extension AudioProperty where SelectorConstant == AudioSubTapPropertySelectorConstant {
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

extension AudioProperty where SelectorConstant == AudioSubTapPropertySelectorConstant, Qualifier == Never, Value == Float64 {
    nonisolated
    public static var extraLatency: Self {
        AudioProperty(selectorConstant: .extraLatency, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioSubTapPropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static var driftCompensation: Self {
        AudioProperty(selectorConstant: .driftCompensation, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioSubTapPropertySelectorConstant, Qualifier == Never, Value == UInt32 {
    nonisolated
    public static var driftCompensationQuality: Self {
        AudioProperty(selectorConstant: .driftCompensationQuality, scope: scope, element: element)
    }
}

#endif
