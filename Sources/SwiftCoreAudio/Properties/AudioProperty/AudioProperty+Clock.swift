//
//  AudioProperty+Clock.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

// swiftformat:disable wrap wrapArguments
// swiftformat:options --wrap-collections preserve

// MARK: Scope & Element

extension AudioProperty where SelectorConstant == AudioClockPropertySelectorConstant {
    nonisolated
    private static var scope: any AudioPropertyScopeConstant {
        .object(.global)
    }

    nonisolated
    private static var element: any AudioPropertyElementConstant {
        .object(.main)
    }
}

// MARK: CoreAudio/AudioHardwareBase.h

extension AudioProperty where SelectorConstant == AudioClockPropertySelectorConstant, Qualifier == Never, Value == String {
    nonisolated
    public static var deviceUID: Self {
        AudioProperty(selectorConstant: .deviceUID, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioClockPropertySelectorConstant, Qualifier == Never, Value == UInt32 {
    nonisolated
    public static var transportType: Self {
        AudioProperty(selectorConstant: .transportType, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioClockPropertySelectorConstant, Qualifier == Never, Value == UInt32 {
    nonisolated
    public static var clockDomain: Self {
        AudioProperty(selectorConstant: .clockDomain, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioClockPropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static var deviceIsAlive: Self {
        AudioProperty(selectorConstant: .deviceIsAlive, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioClockPropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static var deviceIsRunning: Self {
        AudioProperty(selectorConstant: .deviceIsRunning, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioClockPropertySelectorConstant, Qualifier == Never, Value == UInt32 {
    nonisolated
    public static var latency: Self {
        AudioProperty(selectorConstant: .latency, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioClockPropertySelectorConstant, Qualifier == Never, Value == [AudioObjectID] {
    nonisolated
    public static var controlList: Self {
        AudioProperty(selectorConstant: .controlList, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioClockPropertySelectorConstant, Qualifier == Never, Value == Float64 {
    nonisolated
    public static var nominalSampleRate: Self {
        AudioProperty(selectorConstant: .nominalSampleRate, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioClockPropertySelectorConstant, Qualifier == Never, Value == [AudioValueRange] {
    nonisolated
    public static var availableNominalSampleRates: Self {
        AudioProperty(selectorConstant: .availableNominalSampleRates, scope: scope, element: element)
    }
}

#endif
