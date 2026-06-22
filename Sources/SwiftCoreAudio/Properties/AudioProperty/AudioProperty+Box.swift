//
//  AudioProperty+Box.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

// swiftformat:disable wrap wrapArguments
// swiftformat:options --wrap-collections preserve

// MARK: Scope & Element

extension AudioProperty where SelectorConstant == AudioBoxPropertySelectorConstant {
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

extension AudioProperty where SelectorConstant == AudioBoxPropertySelectorConstant, Qualifier == Never, Value == String {
    nonisolated
    public static var boxUID: Self {
        AudioProperty(selectorConstant: .boxUID, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioBoxPropertySelectorConstant, Qualifier == Never, Value == UInt32 {
    nonisolated
    public static var transportType: Self {
        AudioProperty(selectorConstant: .transportType, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioBoxPropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static var hasAudio: Self {
        AudioProperty(selectorConstant: .hasAudio, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioBoxPropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static var hasVideo: Self {
        AudioProperty(selectorConstant: .hasVideo, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioBoxPropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static var hasMIDI: Self {
        AudioProperty(selectorConstant: .hasMIDI, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioBoxPropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static var isProtected: Self {
        AudioProperty(selectorConstant: .isProtected, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioBoxPropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static var acquired: Self {
        AudioProperty(selectorConstant: .acquired, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioBoxPropertySelectorConstant, Qualifier == Never, Value == OSStatus {
    nonisolated
    public static var acquisitionFailed: Self {
        AudioProperty(selectorConstant: .acquisitionFailed, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioBoxPropertySelectorConstant, Qualifier == Never, Value == [AudioObjectID] {
    nonisolated
    public static var deviceList: Self {
        AudioProperty(selectorConstant: .deviceList, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioBoxPropertySelectorConstant, Qualifier == Never, Value == [AudioObjectID] {
    nonisolated
    public static var clockDeviceList: Self {
        AudioProperty(selectorConstant: .clockDeviceList, scope: scope, element: element)
    }
}

#endif
