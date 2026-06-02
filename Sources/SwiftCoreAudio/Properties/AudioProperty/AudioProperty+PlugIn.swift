//
//  AudioProperty+PlugIn.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

// MARK: Scope & Element

extension AudioProperty where SelectorConstant == AudioPlugInPropertySelectorConstant {
    nonisolated
    private static var scope: any AudioPropertyScopeConstant { .object(.global) }
    
    nonisolated
    private static var element: any AudioPropertyElementConstant { .object(.main) }
}

// MARK: CoreAudio/AudioHardwareBase.h

extension AudioProperty where SelectorConstant == AudioPlugInPropertySelectorConstant, Qualifier == Never, Value == String {
    nonisolated
    public static var bundleID: Self {
        AudioProperty(selectorConstant: .bundleID, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioPlugInPropertySelectorConstant, Qualifier == Never, Value == [AudioObjectID] {
    nonisolated
    public static var deviceList: Self {
        AudioProperty(selectorConstant: .deviceList, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioPlugInPropertySelectorConstant, Qualifier == String, Value == AudioObjectID {
    nonisolated
    public static var translateUIDToDevice: Self {
        AudioProperty(selectorConstant: .translateUIDToDevice, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioPlugInPropertySelectorConstant, Qualifier == Never, Value == [AudioObjectID] {
    nonisolated
    public static var boxList: Self {
        AudioProperty(selectorConstant: .boxList, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioPlugInPropertySelectorConstant, Qualifier == String, Value == AudioObjectID {
    nonisolated
    public static var translateUIDToBox: Self {
        AudioProperty(selectorConstant: .translateUIDToBox, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioPlugInPropertySelectorConstant, Qualifier == Never, Value == [AudioObjectID] {
    nonisolated
    public static var clockDeviceList: Self {
        AudioProperty(selectorConstant: .clockDeviceList, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioPlugInPropertySelectorConstant, Qualifier == String, Value == AudioObjectID {
    nonisolated
    public static var translateUIDToClockDevice: Self {
        AudioProperty(selectorConstant: .translateUIDToClockDevice, scope: scope, element: element)
    }
}

// MARK: CoreAudio/AudioHardware.h

extension AudioProperty where SelectorConstant == AudioPlugInPropertySelectorConstant, Qualifier == CFDictionary, Value == AudioObjectID {
    nonisolated
    public static var createAggregateDevice: Self {
        AudioProperty(selectorConstant: .createAggregateDevice, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioPlugInPropertySelectorConstant, Qualifier == AudioObjectID, Value == Never {
    // TODO: not sure what value this returns, docs don't mention
    nonisolated
    public static var destroyAggregateDevice: Self {
        AudioProperty(selectorConstant: .destroyAggregateDevice, scope: scope, element: element)
    }
}

#endif
