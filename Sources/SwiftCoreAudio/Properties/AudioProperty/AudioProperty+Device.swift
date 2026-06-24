//
//  AudioProperty+Device.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

// swiftformat:disable wrap wrapArguments
// swiftformat:options --wrap-collections preserve

// MARK: Scope & Element

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant {
    nonisolated
    private static var defaultScope: any AudioPropertyScopeConstant {
        .object(.global)
    }

    nonisolated
    private static func scope(for direction: AudioStream.Direction) -> any AudioPropertyScopeConstant {
        switch direction {
        case .input: .object(.input)
        case .output: .object(.output)
        }
    }

    nonisolated
    private static var element: any AudioPropertyElementConstant {
        .object(.main)
    }
}

extension AudioProperty where SelectorConstant == AudioObjectPropertySelectorConstant {
    nonisolated
    private static func scope(for direction: AudioStream.Direction) -> any AudioPropertyScopeConstant {
        switch direction {
        case .input: .object(.input)
        case .output: .object(.output)
        }
    }
}

// MARK: - CoreAudio/AudioHardwareBase.h

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == String {
    nonisolated
    public static var configurationApplication: Self {
        AudioProperty(selectorConstant: .configurationApplication, scope: defaultScope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == String {
    nonisolated
    public static var deviceUID: Self {
        AudioProperty(selectorConstant: .deviceUID, scope: defaultScope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == String {
    nonisolated
    public static var modelUID: Self {
        AudioProperty(selectorConstant: .modelUID, scope: defaultScope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == FourCharCode {
    nonisolated
    public static var transportType: Self {
        AudioProperty(selectorConstant: .transportType, scope: defaultScope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == [AudioDeviceID] {
    nonisolated
    public static var relatedDevices: Self {
        AudioProperty(selectorConstant: .relatedDevices, scope: defaultScope, element: element)
    }
}

// TODO: Implement clockDomain

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static var isDeviceAlive: Self { // : Property<Never, Bool> {
        AudioProperty(selectorConstant: .deviceIsAlive, scope: defaultScope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static var isDeviceRunning: Self { // : Property<Never, Bool> {
        AudioProperty(selectorConstant: .deviceIsRunning, scope: defaultScope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static func isSettableAsDefaultDevice(for direction: AudioStream.Direction) -> Self {
        AudioProperty(selectorConstant: .deviceCanBeDefaultDevice, scope: scope(for: direction), element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == UInt32 {
    public static func latency(for direction: AudioStream.Direction) -> Self {
        AudioProperty(selectorConstant: .latency, scope: scope(for: direction), element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == [AudioObjectID] {
    nonisolated
    public static var streams: Self {
        AudioProperty(selectorConstant: .streams, scope: defaultScope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == [AudioObjectID] {
    nonisolated
    public static var controls: Self {
        AudioProperty(selectorConstant: .controlList, scope: defaultScope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == UInt32 {
    nonisolated
    public static func safetyOffset(for direction: AudioStream.Direction) -> Self {
        AudioProperty(selectorConstant: .safetyOffset, scope: scope(for: direction), element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Float64 {
    nonisolated
    public static var nominalSampleRate: Self {
        AudioProperty(selectorConstant: .nominalSampleRate, scope: defaultScope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == [AudioValueRange] {
    nonisolated
    public static var availableNominalSampleRates: Self {
        AudioProperty(selectorConstant: .availableNominalSampleRates, scope: defaultScope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == URL? {
    nonisolated
    public static var icon: Self {
        AudioProperty(selectorConstant: .icon, scope: defaultScope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static var isHidden: Self {
        AudioProperty(selectorConstant: .isHidden, scope: defaultScope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == (UInt32, UInt32) {
    nonisolated
    public static func preferredStereoChannels(for direction: AudioStream.Direction) -> Self {
        AudioProperty(selectorConstant: .preferredChannelsForStereo, scope: scope(for: direction), element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == AudioChannelLayout {
    nonisolated
    public static var preferredChannelLayout: Self {
        AudioProperty(selectorConstant: .preferredChannelLayout, scope: defaultScope, element: element)
    }
}

// MARK: - CoreAudio/AudioHardware.h

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == OSStatus {
    nonisolated
    public static var plugInLoadStatus: Self {
        AudioProperty(selectorConstant: .plugIn, scope: defaultScope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static var isDeviceRunningSomewhere: Self {
        AudioProperty(selectorConstant: .deviceIsRunningSomewhere, scope: defaultScope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Never {
    nonisolated
    public static var processorOverload: Self {
        AudioProperty(selectorConstant: .processorOverload, scope: defaultScope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Never {
    nonisolated
    public static var ioStoppedAbnormally: Self {
        AudioProperty(selectorConstant: .ioStoppedAbnormally, scope: defaultScope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == pid_t {
    nonisolated
    public static var hogModePID: Self {
        AudioProperty(selectorConstant: .hogMode, scope: defaultScope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == UInt32 {
    nonisolated
    public static var bufferFrameSize: Self {
        AudioProperty(selectorConstant: .bufferFrameSize, scope: defaultScope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == AudioValueRange {
    nonisolated
    public static var bufferFrameSizeRange: Self {
        AudioProperty(selectorConstant: .bufferFrameSizeRange, scope: defaultScope, element: element)
    }
}

// TODO: Implement variable buffer frame sizes

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Float32 {
    nonisolated
    public static var ioCycleUsage: Self {
        AudioProperty(selectorConstant: .ioCycleUsage, scope: defaultScope, element: element)
    }
}

// TODO: Implement input/output streamConfiguration

// TODO: Implement ioProcStreamUsage

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Float64 {
    nonisolated
    public static var actualSampleRate: Self {
        AudioProperty(selectorConstant: .actualSampleRate, scope: defaultScope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == String {
    nonisolated
    public static var clockDeviceUID: Self {
        AudioProperty(selectorConstant: .clockDevice, scope: defaultScope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == WorkGroup {
    nonisolated
    public static var workgroup: Self {
        AudioProperty(selectorConstant: .ioThreadOSWorkgroup, scope: defaultScope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static func isCurrentProcessMuted(for direction: AudioStream.Direction) -> Self {
        AudioProperty(selectorConstant: .processMute, scope: scope(for: direction), element: element)
    }
}

// MARK: - Special

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == String {
    nonisolated
    public static func channelName(
        forChannelNumber channelNumber: Int, // 1-based
        of direction: AudioStream.Direction
    ) -> Self {
        AudioProperty(
            selectorConstant: .elementName,
            scope: scope(for: direction),
            element: .stream(.channelNumber(channelNumber))
        )
    }
}

#endif
