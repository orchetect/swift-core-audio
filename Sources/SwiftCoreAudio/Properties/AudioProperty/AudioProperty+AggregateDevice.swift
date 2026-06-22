//
//  AudioProperty+AggregateDevice.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

// swiftformat:disable wrap wrapArguments
// swiftformat:options --wrap-collections preserve

// MARK: Scope & Element

extension AudioProperty where SelectorConstant == AudioAggregateDevicePropertySelectorConstant {
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

extension AudioProperty where SelectorConstant == AudioAggregateDevicePropertySelectorConstant, Qualifier == Never, Value == [String] {
    nonisolated
    public static var fullSubDeviceList: Self {
        AudioProperty(selectorConstant: .fullSubDeviceList, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioAggregateDevicePropertySelectorConstant, Qualifier == Never, Value == [AudioObjectID] {
    nonisolated
    public static var activeSubDeviceList: Self {
        AudioProperty(selectorConstant: .activeSubDeviceList, scope: scope, element: element)
    }
}

// dictionary toll-free bridged from CFDictionary
extension AudioProperty where SelectorConstant == AudioAggregateDevicePropertySelectorConstant, Qualifier == Never, Value == [String: Any] {
    nonisolated
    public static var composition: Self {
        AudioProperty(selectorConstant: .composition, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioAggregateDevicePropertySelectorConstant, Qualifier == Never, Value == String {
    nonisolated
    public static var mainSubDevice: Self {
        AudioProperty(selectorConstant: .mainSubDevice, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioAggregateDevicePropertySelectorConstant, Qualifier == Never, Value == String {
    nonisolated
    public static var clockDevice: Self {
        AudioProperty(selectorConstant: .clockDevice, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioAggregateDevicePropertySelectorConstant, Qualifier == Never, Value == [String] {
    nonisolated
    public static var tapList: Self {
        AudioProperty(selectorConstant: .tapList, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioAggregateDevicePropertySelectorConstant, Qualifier == Never, Value == [AudioObjectID] {
    nonisolated
    public static var subtapList: Self {
        AudioProperty(selectorConstant: .subTapList, scope: scope, element: element)
    }
}

#endif
