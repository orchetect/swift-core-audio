//
//  AudioProperty+System.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

// MARK: Scope & Element

extension AudioProperty where SelectorConstant == AudioSystemPropertySelectorConstant {
    nonisolated
    private static var scope: any AudioPropertyScopeConstant { .object(.global) }
    
    nonisolated
    private static var element: any AudioPropertyElementConstant { .object(.main) }
}

// MARK: CoreAudio/AudioHardware.h

extension AudioProperty where SelectorConstant == AudioSystemPropertySelectorConstant, Qualifier == Never, Value == [AudioObjectID] {
    nonisolated
    public static var devices: Self {
        AudioProperty(selectorConstant: .devices, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioSystemPropertySelectorConstant, Qualifier == Never, Value == AudioObjectID {
    nonisolated
    public static var defaultInputDevice: Self {
        AudioProperty(selectorConstant: .defaultInputDevice, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioSystemPropertySelectorConstant, Qualifier == Never, Value == AudioObjectID {
    nonisolated
    public static var defaultOutputDevice: Self {
        AudioProperty(selectorConstant: .defaultOutputDevice, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioSystemPropertySelectorConstant, Qualifier == Never, Value == AudioObjectID {
    nonisolated
    public static var defaultOutputDeviceForSystemSounds: Self {
        AudioProperty(selectorConstant: .defaultSystemOutputDevice, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioSystemPropertySelectorConstant, Qualifier == CFString, Value == AudioObjectID {
    nonisolated
    public static var deviceForUID: Self {
        AudioProperty(selectorConstant: .translateUIDToDevice, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioSystemPropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static var isStereoMixedDownToMono: Self {
        AudioProperty(selectorConstant: .mixStereoToMono, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioSystemPropertySelectorConstant, Qualifier == Never, Value == [AudioObjectID] {
    nonisolated
    public static var plugIns: Self {
        AudioProperty(selectorConstant: .plugInList, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioSystemPropertySelectorConstant, Qualifier == CFString, Value == AudioObjectID {
    nonisolated
    public static var plugInForBundleID: Self {
        AudioProperty(selectorConstant: .translateBundleIDToPlugIn, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioSystemPropertySelectorConstant, Qualifier == Never, Value == [AudioObjectID] {
    nonisolated
    public static var transportManagers: Self {
        AudioProperty(selectorConstant: .transportManagerList, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioSystemPropertySelectorConstant, Qualifier == CFString, Value == AudioObjectID {
    nonisolated
    public static var transportManagerForBundleID: Self {
        AudioProperty(selectorConstant: .translateBundleIDToTransportManager, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioSystemPropertySelectorConstant, Qualifier == Never, Value == [AudioObjectID] {
    nonisolated
    public static var boxes: Self { // Property<Never, [AudioObjectID]> {
        AudioProperty(selectorConstant: .boxList, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioSystemPropertySelectorConstant, Qualifier == CFString, Value == AudioObjectID {
    nonisolated
    public static var boxForUID: Self {
        AudioProperty(selectorConstant: .translateUIDToBox, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioSystemPropertySelectorConstant, Qualifier == Never, Value == [AudioObjectID] {
    nonisolated
    public static var clocks: Self {
        AudioProperty(selectorConstant: .clockDeviceList, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioSystemPropertySelectorConstant, Qualifier == CFString, Value == AudioObjectID {
    nonisolated
    public static var clockForUID: Self {
        AudioProperty(selectorConstant: .translateUIDToClockDevice, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioSystemPropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static var isProcessMain: Self {
        AudioProperty(selectorConstant: .processIsMain, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioSystemPropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static var isInitingOrExiting: Self {
        AudioProperty(selectorConstant: .isInitingOrExiting, scope: scope, element: element)
    }
}

// Note: `userIDChanged` is write-only, read is unused

extension AudioProperty where SelectorConstant == AudioSystemPropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static var isProcessMutedForInput: Self {
        AudioProperty(selectorConstant: .processInputMute, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioSystemPropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static var isProcessMutedForOutput: Self {
        AudioProperty(selectorConstant: .processIsAudible, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioSystemPropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static var isSleepingAllowed: Self {
        AudioProperty(selectorConstant: .sleepingIsAllowed, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioSystemPropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static var isUnloadingAllowed: Self {
        AudioProperty(selectorConstant: .unloadingIsAllowed, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioSystemPropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static var isHogModeAllowed: Self {
        AudioProperty(selectorConstant: .hogModeIsAllowed, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioSystemPropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static var isUserSessionForProcessActiveOrHeadless: Self {
        AudioProperty(selectorConstant: .userSessionIsActiveOrHeadless, scope: scope, element: element)
    }
}

// Note: `serviceRestarted` is used only for notifications

extension AudioProperty where SelectorConstant == AudioSystemPropertySelectorConstant, Qualifier == Never, Value == UInt32 {
    nonisolated
    public static var powerHint: Self {
        AudioProperty(selectorConstant: .processObjectList, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioSystemPropertySelectorConstant, Qualifier == Never, Value == [AudioObjectID] {
    nonisolated
    public static var processes: Self {
        AudioProperty(selectorConstant: .processObjectList, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioSystemPropertySelectorConstant, Qualifier == pid_t, Value == AudioObjectID {
    nonisolated
    public static var processForPID: Self {
        AudioProperty(selectorConstant: .translatePIDToProcessObject, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioSystemPropertySelectorConstant, Qualifier == Never, Value == [AudioObjectID] {
    nonisolated
    public static var taps: Self {
        AudioProperty(selectorConstant: .tapList, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioSystemPropertySelectorConstant, Qualifier == CFString, Value == AudioObjectID {
    nonisolated
    public static var tapForUID: Self {
        AudioProperty(selectorConstant: .translateUIDToTap, scope: scope, element: element)
    }
}

#endif
