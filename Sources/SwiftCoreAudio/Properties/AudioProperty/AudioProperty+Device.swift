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
    private static var defaultElement: any AudioPropertyElementConstant {
        .object(.main)
    }

    /// Channel value of `nil` refers to main.
    nonisolated
    private static func element(forChannel channel: Int?) -> any AudioPropertyElementConstant{
        if let channel {
            .stream(.channelNumber(channel))
        } else {
            .object(.main)
        }
    }
}

// MARK: - CoreAudio/AudioHardwareBase.h

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == String {
    nonisolated
    public static var configurationApplication: Self {
        AudioProperty(selectorConstant: .configurationApplication, scope: defaultScope, element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == String {
    nonisolated
    public static var deviceUID: Self {
        AudioProperty(selectorConstant: .deviceUID, scope: defaultScope, element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == String {
    nonisolated
    public static var modelUID: Self {
        AudioProperty(selectorConstant: .modelUID, scope: defaultScope, element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == FourCharCode {
    nonisolated
    public static var transportType: Self {
        AudioProperty(selectorConstant: .transportType, scope: defaultScope, element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == [AudioDeviceID] {
    nonisolated
    public static var relatedDevices: Self {
        AudioProperty(selectorConstant: .relatedDevices, scope: defaultScope, element: defaultElement)
    }
}

// TODO: Implement clockDomain

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static var isDeviceAlive: Self { // : Property<Never, Bool> {
        AudioProperty(selectorConstant: .deviceIsAlive, scope: defaultScope, element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static var isDeviceRunning: Self { // : Property<Never, Bool> {
        AudioProperty(selectorConstant: .deviceIsRunning, scope: defaultScope, element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static func isSettableAsDefaultDevice(for direction: AudioStream.Direction) -> Self {
        AudioProperty(selectorConstant: .deviceCanBeDefaultDevice, scope: scope(for: direction), element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == UInt32 {
    public static func latency(for direction: AudioStream.Direction) -> Self {
        AudioProperty(selectorConstant: .latency, scope: scope(for: direction), element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == [AudioObjectID] {
    nonisolated
    public static var streams: Self {
        AudioProperty(selectorConstant: .streams, scope: defaultScope, element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == [AudioObjectID] {
    nonisolated
    public static var controls: Self {
        AudioProperty(selectorConstant: .controlList, scope: defaultScope, element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == UInt32 {
    nonisolated
    public static func safetyOffset(for direction: AudioStream.Direction) -> Self {
        AudioProperty(selectorConstant: .safetyOffset, scope: scope(for: direction), element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Float64 {
    nonisolated
    public static var nominalSampleRate: Self {
        AudioProperty(selectorConstant: .nominalSampleRate, scope: defaultScope, element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == [AudioValueRange] {
    nonisolated
    public static var availableNominalSampleRates: Self {
        AudioProperty(selectorConstant: .availableNominalSampleRates, scope: defaultScope, element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == URL? {
    nonisolated
    public static var icon: Self {
        AudioProperty(selectorConstant: .icon, scope: defaultScope, element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static var isHidden: Self {
        AudioProperty(selectorConstant: .isHidden, scope: defaultScope, element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == (UInt32, UInt32) {
    nonisolated
    public static func preferredStereoChannels(for direction: AudioStream.Direction) -> Self {
        AudioProperty(selectorConstant: .preferredChannelsForStereo, scope: scope(for: direction), element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == AudioChannelLayout {
    nonisolated
    public static var preferredChannelLayout: Self {
        AudioProperty(selectorConstant: .preferredChannelLayout, scope: defaultScope, element: defaultElement)
    }
}

// MARK: - CoreAudio/AudioHardware.h

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == OSStatus {
    nonisolated
    public static var plugInLoadStatus: Self {
        AudioProperty(selectorConstant: .plugIn, scope: defaultScope, element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static var isDeviceRunningSomewhere: Self {
        AudioProperty(selectorConstant: .deviceIsRunningSomewhere, scope: defaultScope, element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Never {
    nonisolated
    public static var processorOverload: Self {
        AudioProperty(selectorConstant: .processorOverload, scope: defaultScope, element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Never {
    nonisolated
    public static var ioStoppedAbnormally: Self {
        AudioProperty(selectorConstant: .ioStoppedAbnormally, scope: defaultScope, element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == pid_t {
    nonisolated
    public static var hogModePID: Self {
        AudioProperty(selectorConstant: .hogMode, scope: defaultScope, element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == UInt32 {
    nonisolated
    public static var bufferFrameSize: Self {
        AudioProperty(selectorConstant: .bufferFrameSize, scope: defaultScope, element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == AudioValueRange {
    nonisolated
    public static var bufferFrameSizeRange: Self {
        AudioProperty(selectorConstant: .bufferFrameSizeRange, scope: defaultScope, element: defaultElement)
    }
}

// TODO: Implement variable buffer frame sizes

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Float32 {
    nonisolated
    public static var ioCycleUsage: Self {
        AudioProperty(selectorConstant: .ioCycleUsage, scope: defaultScope, element: defaultElement)
    }
}

// TODO: Implement input/output streamConfiguration

// TODO: Implement ioProcStreamUsage

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Float64 {
    nonisolated
    public static var actualSampleRate: Self {
        AudioProperty(selectorConstant: .actualSampleRate, scope: defaultScope, element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == String {
    nonisolated
    public static var clockDeviceUID: Self {
        AudioProperty(selectorConstant: .clockDevice, scope: defaultScope, element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == WorkGroup {
    nonisolated
    public static var workgroup: Self {
        AudioProperty(selectorConstant: .ioThreadOSWorkgroup, scope: defaultScope, element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static func isCurrentProcessMuted(for direction: AudioStream.Direction) -> Self {
        AudioProperty(selectorConstant: .processMute, scope: scope(for: direction), element: defaultElement)
    }
}

// MARK: - CoreAudio/AudioHardware.h - Device properties implemented via AudioControl objects

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static func isJackConnected(for direction: AudioStream.Direction, channel: Int?) -> Self {
        AudioProperty(selectorConstant: .jackIsConnected, scope: scope(for: direction), element: element(forChannel: channel))
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Float32 {
    nonisolated
    public static func volumeScalar(for direction: AudioStream.Direction, channel: Int?) -> Self {
        AudioProperty(selectorConstant: .volumeScalar, scope: scope(for: direction), element: element(forChannel: channel))
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Float32 {
    nonisolated
    public static func volumeDecibels(for direction: AudioStream.Direction, channel: Int?) -> Self {
        AudioProperty(selectorConstant: .volumeDecibels, scope: scope(for: direction), element: element(forChannel: channel))
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == AudioValueRange {
    nonisolated
    public static func volumeRangeDecibels(for direction: AudioStream.Direction, channel: Int?) -> Self {
        AudioProperty(selectorConstant: .volumeRangeDecibels, scope: scope(for: direction), element: element(forChannel: channel))
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Float32 {
    nonisolated
    public static func volumeScalarToDecibels(for direction: AudioStream.Direction, channel: Int?) -> Self {
        AudioProperty(selectorConstant: .volumeScalarToDecibels, scope: scope(for: direction), element: element(forChannel: channel))
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Float32 {
    nonisolated
    public static func volumeDecibelsToScalar(for direction: AudioStream.Direction, channel: Int?) -> Self {
        AudioProperty(selectorConstant: .volumeDecibelsToScalar, scope: scope(for: direction), element: element(forChannel: channel))
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Float32 {
    // TODO: Not sure if element is applicable. Can individual channels have pan controls?
    nonisolated
    public static func stereoPan(for direction: AudioStream.Direction, channel: Int?) -> Self {
        AudioProperty(selectorConstant: .stereoPan, scope: scope(for: direction), element: element(forChannel: channel))
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == (UInt32, UInt32) {
    // TODO: Not sure if element is applicable. Can individual channels have pan controls?
    nonisolated
    public static func stereoPanChannels(for direction: AudioStream.Direction) -> Self {
        AudioProperty(selectorConstant: .stereoPanChannels, scope: scope(for: direction), element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static func isMuted(for direction: AudioStream.Direction, channel: Int?) -> Self {
        AudioProperty(selectorConstant: .mute, scope: scope(for: direction), element: element(forChannel: channel))
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static func isSoloed(for direction: AudioStream.Direction, channel: Int?) -> Self {
        AudioProperty(selectorConstant: .solo, scope: scope(for: direction), element: element(forChannel: channel))
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static func isPhantomPowerEnabled(forInputChannel channel: Int?) -> Self {
        AudioProperty(selectorConstant: .phantomPower, scope: .object(.input), element: element(forChannel: channel))
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static func isPhaseInverted(for direction: AudioStream.Direction, channel: Int?) -> Self {
        AudioProperty(selectorConstant: .phaseInvert, scope: scope(for: direction), element: element(forChannel: channel))
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static func isClipLightOn(for direction: AudioStream.Direction, channel: Int?) -> Self {
        AudioProperty(selectorConstant: .clipLight, scope: scope(for: direction), element: element(forChannel: channel))
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static var isTalkbackEnabled: Self {
        AudioProperty(selectorConstant: .talkback, scope: defaultScope, element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static var isListenbackEnabled: Self {
        AudioProperty(selectorConstant: .listenback, scope: defaultScope, element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == [UInt32] {
    nonisolated
    public static func dataSource(for direction: AudioStream.Direction) -> Self {
        AudioProperty(selectorConstant: .dataSource, scope: scope(for: direction), element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == [UInt32] {
    nonisolated
    public static func dataSources(for direction: AudioStream.Direction) -> Self {
        AudioProperty(selectorConstant: .dataSources, scope: scope(for: direction), element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == AudioPropertyValueTranslation<UInt32, String> {
    nonisolated
    public static func dataSourceNameForID(for direction: AudioStream.Direction) -> Self {
        AudioProperty(selectorConstant: .dataSourceNameForIDCFString, scope: scope(for: direction), element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == AudioPropertyValueTranslation<UInt32, UInt32> {
    nonisolated
    public static func dataSourceKindForID(for direction: AudioStream.Direction) -> Self {
        AudioProperty(selectorConstant: .dataSourceKindForID, scope: scope(for: direction), element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == [UInt32] {
    // Anecdotally, returns same value whether scope is global, input, or output.
    // Anecdotally, element is not used and should always be main. Passing channel numbers returns 'unknown property' status.
    nonisolated
    public static var clockSource: Self {
        AudioProperty(selectorConstant: .clockSource, scope: defaultScope, element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == [UInt32] {
    // TODO: Not sure if scope or element are applicable.
    nonisolated
    public static var clockSources: Self {
        AudioProperty(selectorConstant: .clockSources, scope: defaultScope, element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == AudioPropertyValueTranslation<UInt32, String> {
    nonisolated
    public static var clockSourceNameForID: Self {
        AudioProperty(selectorConstant: .clockSourceNameForIDCFString, scope: defaultScope, element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == AudioPropertyValueTranslation<UInt32, UInt32> {
    nonisolated
    public static var clockSourceKindForID: Self {
        AudioProperty(selectorConstant: .clockSourceKindForID, scope: defaultScope, element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Bool {
    // TODO: Not sure if scope or element are applicable.
    nonisolated
    public static func isPlayThruEnabled(for direction: AudioStream.Direction, channel: Int?) -> Self {
        AudioProperty(selectorConstant: .playThru, scope: scope(for: direction), element: element(forChannel: channel))
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Bool {
    // TODO: Not sure if scope is applicable.
    nonisolated
    public static func isPlayThruSoloed(for direction: AudioStream.Direction, channel: Int?) -> Self {
        AudioProperty(selectorConstant: .playThruSolo, scope: scope(for: direction), element: element(forChannel: channel))
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Float32 {
    // TODO: Not sure if scope is applicable.
    nonisolated
    public static func playThruVolumeScalar(for direction: AudioStream.Direction, channel: Int?) -> Self {
        AudioProperty(selectorConstant: .playThruVolumeScalar, scope: scope(for: direction), element: element(forChannel: channel))
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Float32 {
    // TODO: Not sure if scope is applicable.
    nonisolated
    public static func playThruVolumeDecibels(for direction: AudioStream.Direction, channel: Int?) -> Self {
        AudioProperty(selectorConstant: .playThruVolumeDecibels, scope: scope(for: direction), element: element(forChannel: channel))
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == AudioValueRange {
    // TODO: Not sure if scope is applicable.
    nonisolated
    public static func playThruVolumeRangeDecibels(for direction: AudioStream.Direction, channel: Int?) -> Self {
        AudioProperty(selectorConstant: .playThruVolumeRangeDecibels, scope: scope(for: direction), element: element(forChannel: channel))
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Float32 {
    nonisolated
    public static func playThruVolumeScalarToDecibels(for direction: AudioStream.Direction, channel: Int?) -> Self {
        AudioProperty(selectorConstant: .playThruVolumeScalarToDecibels, scope: scope(for: direction), element: element(forChannel: channel))
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Float32 {
    nonisolated
    public static func playThruVolumeDecibelsToScalar(for direction: AudioStream.Direction, channel: Int?) -> Self {
        AudioProperty(selectorConstant: .playThruVolumeDecibelsToScalar, scope: scope(for: direction), element: element(forChannel: channel))
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Float32 {
    // TODO: Not sure if scope is applicable.
    nonisolated
    public static func playThruStereoPan(for direction: AudioStream.Direction, channel: Int?) -> Self {
        AudioProperty(selectorConstant: .playThruStereoPan, scope: scope(for: direction), element: element(forChannel: channel))
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == (UInt32, UInt32) {
    // TODO: Not sure if scope is applicable.
    nonisolated
    public static func playThruStereoPanChannels(for direction: AudioStream.Direction) -> Self {
        AudioProperty(selectorConstant: .playThruStereoPanChannels, scope: scope(for: direction), element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == [UInt32] {
    // TODO: Not sure if element is applicable.
    nonisolated
    public static var playThruDestination: Self {
        AudioProperty(selectorConstant: .playThruDestination, scope: .object(.playThrough), element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == [UInt32] {
    // TODO: Not sure if element is applicable.
    nonisolated
    public static var playThruDestinations: Self {
        AudioProperty(selectorConstant: .playThruDestinations, scope: .object(.playThrough), element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == AudioPropertyValueTranslation<UInt32, String> {
    nonisolated
    public static var playThruDestinationNameForID: Self {
        AudioProperty(selectorConstant: .playThruDestinationNameForIDCFString, scope: defaultScope, element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == [UInt32] {
    // TODO: Not sure if scope or element are applicable.
    nonisolated
    public static var channelNominalLineLevel: Self {
        AudioProperty(selectorConstant: .channelNominalLineLevel, scope: defaultScope, element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == [UInt32] {
    // TODO: Not sure if scope or element are applicable.
    nonisolated
    public static var channelNominalLineLevels: Self {
        AudioProperty(selectorConstant: .channelNominalLineLevels, scope: defaultScope, element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == AudioPropertyValueTranslation<UInt32, String> {
    nonisolated
    public static var channelNominalLineLevelNameForID: Self {
        AudioProperty(selectorConstant: .channelNominalLineLevelNameForIDCFString, scope: defaultScope, element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == [UInt32] {
    // TODO: Not sure if scope or element are applicable.
    nonisolated
    public static var highPassFilterSetting: Self {
        AudioProperty(selectorConstant: .highPassFilterSetting, scope: defaultScope, element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == [UInt32] {
    // TODO: Not sure if scope or element are applicable.
    nonisolated
    public static var highPassFilterSettings: Self {
        AudioProperty(selectorConstant: .highPassFilterSettings, scope: defaultScope, element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == AudioPropertyValueTranslation<UInt32, String> {
    nonisolated
    public static var highPassFilterSettingNameForID: Self {
        AudioProperty(selectorConstant: .highPassFilterSettingNameForIDCFString, scope: defaultScope, element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Float32 {
    nonisolated
    public static var subVolumeScalar: Self {
        AudioProperty(selectorConstant: .subVolumeScalar, scope: defaultScope, element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Float32 {
    nonisolated
    public static var subVolumeDecibels: Self {
        AudioProperty(selectorConstant: .subVolumeDecibels, scope: defaultScope, element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == AudioValueRange {
    nonisolated
    public static var subVolumeRangeDecibels: Self {
        AudioProperty(selectorConstant: .subVolumeRangeDecibels, scope: defaultScope, element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Float32 {
    nonisolated
    public static var subVolumeScalarToDecibels: Self {
        AudioProperty(selectorConstant: .subVolumeScalarToDecibels, scope: defaultScope, element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Float32 {
    nonisolated
    public static var subVolumeDecibelsToScalar: Self {
        AudioProperty(selectorConstant: .subVolumeDecibelsToScalar, scope: defaultScope, element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static var isSubMuted: Self {
        AudioProperty(selectorConstant: .subMute, scope: defaultScope, element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static func isVoiceActivityDetectionEnabled(forInputChannel channel: Int) -> Self {
        AudioProperty(selectorConstant: .voiceActivityDetectionEnable, scope: .object(.input), element: element(forChannel: channel))
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static func isVoiceActivityDetected(forInputChannel channel: Int) -> Self {
        AudioProperty(selectorConstant: .voiceActivityDetectionState, scope: .object(.input), element: element(forChannel: channel))
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static var isControlRestorationWanted: Self {
        AudioProperty(selectorConstant: .wantsControlsRestored, scope: defaultScope, element: defaultElement)
    }
}

extension AudioProperty where SelectorConstant == AudioDevicePropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static var isStreamFormatsRestorationWanted: Self {
        AudioProperty(selectorConstant: .wantsStreamFormatsRestored, scope: defaultScope, element: defaultElement)
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
