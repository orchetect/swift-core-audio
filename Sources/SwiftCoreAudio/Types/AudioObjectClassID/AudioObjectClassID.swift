//
//  AudioObjectClassID.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import Foundation

/// Lightweight wrapper for the class ID value (`AudioClassID`) that identifies each
/// `AudioObject` subclass.
///
/// These values correspond to Core Audio's `kAudio*ClassID` constants.
public enum AudioObjectClassID {
    // MARK: CoreAudio/AudioHardwareBase.h

    // TODO: Wildcard should be split into its own type or treated separately
    /// The wildcard value for `AudioClassIDs`.
    case wildcard

    /// The `AudioClassID` that identifies the `AudioObject` class.
    case object

    /// The `AudioClassID` that identifies the `AudioPlugIn` class.
    case plugIn

    /// The `AudioClassID` that identifies the `AudioTransportManager` class.
    case transportManager

    /// The `AudioClassID` that identifies the `AudioBox` class.
    case box

    /// The `AudioClassID` that identifies the `AudioDevice` class.
    case device

    /// The `AudioClassID` that identifies the `AudioClockDevice` class.
    case clock

    /// The `AudioClassID` that identifies the `AudioEndPointDevice` class.
    case endPointDevice

    /// The `AudioClassID` that identifies the `AudioEndPoint` class.
    case endPoint

    /// The `AudioClassID` that identifies the `AudioStream` class.
    case stream

    // MARK: CoreAudio/AudioHardwareBase.h - Controls

    /// The `AudioClassID` that identifies the `AudioControl` class.
    case control

    /// The `AudioClassID` that identifies the `AudioSliderControl` class.
    case sliderControl

    // MARK: CoreAudio/AudioHardwareBase.h - Level Controls

    /// The `AudioClassID` that identifies the `AudioLevelControl` class.
    case levelControl

    /// The `AudioClassID` that identifies the `AudioVolumeControl` class.
    ///
    /// A subclass of the `AudioLevelControl` class that implements a general
    /// gain/attenuation stage.
    case volumeControl

    /// A subclass of the `AudioLevelControl` class for an LFE channel that results from
    /// bass management.
    ///
    /// Note that LFE channels that are represented as normal audio channels must use
    /// `kAudioVolumeControlClassID` (``volumeControl``) to manipulate the level.
    case lfeVolumeControl

    // MARK: CoreAudio/AudioHardwareBase.h - Boolean Controls

    /// The `AudioClassID` that identifies the `AudioBooleanControl` class.
    case booleanControl

    /// A subclass of the `AudioBooleanControl` class where a `true` value means that
    /// mute is enabled making that element inaudible.
    case muteControl

    /// A subclass of the `AudioBooleanControl` class where a `true` value means that
    /// solo is enabled, making just that element audible and the other elements
    /// inaudible.
    case soloControl

    /// A subclass of the `AudioBooleanControl` class where a `true` value means
    /// something is plugged into that element.
    case jackControl

    /// A subclass of the `AudioBooleanControl` class where `true` means that mute is
    /// enabled making that LFE element inaudible.
    ///
    /// This control is for LFE channels that result from bass management.
    ///
    /// Note that LFE channels that are represented as normal audio channels must use an
    /// `AudioMuteControl`.
    case lfeMuteControl

    /// A subclass of the `AudioBooleanControl` class where `true` means that the
    /// element's hardware has phantom power enabled.
    case phantomPowerControl

    /// A subclass of the `AudioBooleanControl` class where `true` means that the phase
    /// of the signal on the given element is being inverted by 180 degrees.
    case phaseInvertControl

    /// A subclass of the `AudioBooleanControl` class where `true` means that the signal
    /// for the element has exceeded the sample range.
    ///
    /// Once a clip light is turned on, it is to stay on until either the value of the control is
    /// set to `false` or the current IO session stops and a new IO session starts.
    case clipLightControl

    /// An `AudioBooleanControl` where `true` means that the talkback channel is
    /// enabled.
    ///
    /// This control is for talkback channels that are handled outside of the regular IO channels.
    /// If the talkback channel is among the normal IO channels, it will use `AudioMuteControl`.
    case talkbackControl

    /// An `AudioBooleanControl` where `true` means that the listenback channel is
    /// audible.
    ///
    /// This control is for listenback channels that are handled outside of the regular IO channels.
    /// If the listenback channel is among the normal IO channels, it will use `AudioMuteControl`.
    case listenbackControl

    // MARK: CoreAudio/AudioHardwareBase.h - Selector Controls

    /// The `AudioClassID` that identifies the `AudioSelectorControl` class.
    case selectorControl

    /// A subclass of the `AudioSelectorControl` class that identifies where the data
    /// for the element is coming from.
    case dataSourceControl

    /// A subclass of the `AudioSelectorControl` class that identifies where the data
    /// for the element is going.
    case dataDestinationControl

    /// A subclass of the `AudioSelectorControl` class that identifies where the
    /// timing info for the object is coming from.
    case clockSourceControl

    /// A subclass of the `AudioSelectorControl` class that identifies the nominal
    /// line level for the element.
    ///
    /// Note that this is not a gain stage but rather indicating the voltage standard (if any)
    /// used for the element, such as +4dBu, -10dBV, instrument, etc.
    case lineLevelControl

    /// A subclass of the `AudioSelectorControl` class that indicates the setting for
    /// the high pass filter on the given element.
    case highPassFilterControl

    // MARK: CoreAudio/AudioHardwareBase.h - Stereo Pan Control

    /// The `AudioClassID` that identifies the `AudioStereoPanControl` class.
    case stereoPanControl

    // MARK: CoreAudio/AudioHardware.h

    /// The `AudioClassID` that identifies the `AudioSystemObject` class.
    case system

    /// The `AudioClassID` that identifies the `AudioAggregateDevice` class.
    case aggregate

    /// The `AudioClassID` that identifies the `AudioSubDevice` class.
    case subdevice

    /// The `AudioClassID` that identifies the `AudioSubTap` class.
    case subtap

    /// The `AudioClassID` that identifies the `AudioProcess` class.
    case process

    /// The `AudioClassID` that identifies the `AudioTap` class.
    case tap

    // MARK: CoreAudio/AudioHardwareDeprecated.h

    /// A subclass of the `AudioBooleanControl` where `true` means that the `AudioDevice` that
    /// ultimately owns the control also owns any iSub attached to the CPU.
    case iSubOwnerControl

    /// A subclass of the `AudioLevelControl` class for the boot chime of the CPU.
    case bootChimeVolumeControl
}

extension AudioObjectClassID: Equatable { }

extension AudioObjectClassID: Hashable { }

extension AudioObjectClassID: CaseIterable { }

extension AudioObjectClassID: Sendable { }

// MARK: - Inits

extension AudioObjectClassID {
    /// Same as ``init(rawValue:)`` but throws an error instead of returning `nil` when a match is not found.
    nonisolated
    public init(tryingRawValue rawValue: AudioClassID) throws(SwiftCoreAudioError) { // a.k.a. UInt32
        guard let match = Self(rawValue: rawValue) else {
            throw .notYetImplemented(message: "Unhandled/unrecognized audio class ID value: \(rawValue)")
        }
        self = match
    }
}

// MARK: - RawRepresentable

extension AudioObjectClassID: RawRepresentable {
    nonisolated
    public init?(rawValue: AudioClassID) { // a.k.a. UInt32
        guard let match = Self.allCases
            .first(where: { $0.rawValue == rawValue })
        else {
            return nil
        }
        self = match
    }

    nonisolated
    public var rawValue: AudioClassID { // a.k.a. UInt32
        switch self {
        // MARK: CoreAudio/AudioHardwareBase.h

        case .wildcard: kAudioObjectClassIDWildcard // "****"
        case .object: kAudioObjectClassID // "aobj"
        case .plugIn: kAudioPlugInClassID // "aplg"
        case .transportManager: kAudioTransportManagerClassID // "trpm"
        case .box: kAudioBoxClassID // "abox"
        case .device: kAudioDeviceClassID // "adev"
        case .clock: kAudioClockDeviceClassID // "aclk"
        case .endPointDevice: kAudioEndPointDeviceClassID // "edev"
        case .endPoint: kAudioEndPointClassID // "endp"
        case .stream: kAudioStreamClassID // "astr"

        // MARK: CoreAudio/AudioHardwareBase.h - Controls
        case .control: kAudioControlClassID // "actl"
        case .sliderControl: kAudioSliderControlClassID // "sldr"

        // MARK: CoreAudio/AudioHardwareBase.h - Level Controls
        case .levelControl: kAudioLevelControlClassID // "levl"
        case .volumeControl: kAudioVolumeControlClassID // "vlme"
        case .lfeVolumeControl: kAudioLFEVolumeControlClassID // "subv"

        // MARK: CoreAudio/AudioHardwareBase.h - Boolean Controls
        case .booleanControl: kAudioBooleanControlClassID // "togl"
        case .muteControl: kAudioMuteControlClassID // "mute"
        case .soloControl: kAudioSoloControlClassID // "solo"
        case .jackControl: kAudioJackControlClassID // "jack"
        case .lfeMuteControl: kAudioLFEMuteControlClassID // "subm"
        case .phantomPowerControl: kAudioPhantomPowerControlClassID // "phan"
        case .phaseInvertControl: kAudioPhaseInvertControlClassID // "phsi"
        case .clipLightControl: kAudioClipLightControlClassID // "clip"
        case .talkbackControl: kAudioTalkbackControlClassID // "talb"
        case .listenbackControl: kAudioListenbackControlClassID // "lsnb"

        // MARK: CoreAudio/AudioHardwareBase.h - Selector Controls
        case .selectorControl: kAudioSelectorControlClassID // "slct"
        case .dataSourceControl: kAudioDataSourceControlClassID // "dsrc"
        case .dataDestinationControl: kAudioDataDestinationControlClassID // "dest"
        case .clockSourceControl: kAudioClockSourceControlClassID // "clck"
        case .lineLevelControl: kAudioLineLevelControlClassID // "nlvl"
        case .highPassFilterControl: kAudioHighPassFilterControlClassID // "hipf"

        // MARK: CoreAudio/AudioHardwareBase.h - Stereo Pan Control
        case .stereoPanControl: kAudioStereoPanControlClassID // "span"

        // MARK: CoreAudio/AudioHardware.h
        case .system: kAudioSystemObjectClassID // "asys"
        case .aggregate: kAudioAggregateDeviceClassID // "aagg"
        case .subdevice: kAudioSubDeviceClassID // "asub"
        case .subtap: kAudioSubTapClassID // "stap"
        case .process: kAudioProcessClassID // "clnt"
        case .tap: kAudioTapClassID // "tcls

        // MARK: CoreAudio/AudioHardwareDeprecated.h
        case .iSubOwnerControl: kAudioISubOwnerControlClassID // "atch"
        case .bootChimeVolumeControl: kAudioBootChimeVolumeControlClassID // "pram"
        }
    }
}

extension AudioObjectClassID: CustomStringConvertible {
    nonisolated
    public var description: String {
        name
    }
}

extension AudioObjectClassID {
    /// Returns a human-readable English name for a single instance of the class type.
    nonisolated
    public var name: String {
        switch self {
        // MARK: CoreAudio/AudioHardwareBase.h

        case .wildcard: "Wildcard"
        case .object: "Object"
        case .plugIn: "PlugIn"
        case .transportManager: "Transport Manager"
        case .box: "Box"
        case .device: "Device"
        case .clock: "Clock"
        case .endPointDevice: "EndPoint Device"
        case .endPoint: "EndPoint"
        case .stream: "Stream"

        // MARK: CoreAudio/AudioHardwareBase.h - Controls
        case .control: "Control"
        case .sliderControl: "Slider Control"

        // MARK: CoreAudio/AudioHardwareBase.h - Level Controls
        case .levelControl: "Level Control"
        case .volumeControl: "Volume Control"
        case .lfeVolumeControl: "LFE Volume Control"

        // MARK: CoreAudio/AudioHardwareBase.h - Boolean Controls
        case .booleanControl: "Boolean Control"
        case .muteControl: "Mute Control"
        case .soloControl: "Solo Control"
        case .jackControl: "Jack Control"
        case .lfeMuteControl: "LFE Mute Control"
        case .phantomPowerControl: "Phantom Power Control"
        case .phaseInvertControl: "Phase Invert Control"
        case .clipLightControl: "Clip Light Control"
        case .talkbackControl: "Talkback Control"
        case .listenbackControl: "Listenback Control"

        // MARK: CoreAudio/AudioHardwareBase.h - Selector Controls
        case .selectorControl: "Selector Control"
        case .dataSourceControl: "Data Source Control"
        case .dataDestinationControl: "Data Destination Control"
        case .clockSourceControl: "Clock Source Control"
        case .lineLevelControl: "Line Level Control"
        case .highPassFilterControl: "High Pass Filter Control"

        // MARK: CoreAudio/AudioHardwareBase.h - Stereo Pan Control
        case .stereoPanControl: "Stereo Pan Control"

        // MARK: CoreAudio/AudioHardware.h
        case .system: "System"
        case .aggregate: "Aggregate"
        case .subdevice: "Subdevice"
        case .subtap: "Subtap"
        case .process: "Process"
        case .tap: "Tap"

        // MARK: CoreAudio/AudioHardwareDeprecated.h
        case .iSubOwnerControl: "iSub Owner Control"
        case .bootChimeVolumeControl: "Boot Chime Volume Control"
        }
    }

    /// Returns a human-readable English plural name of the class type.
    nonisolated
    public var pluralName: String {
        switch self {
        // MARK: CoreAudio/AudioHardwareBase.h

        case .wildcard: "Wildcards"
        case .object: "Objects"
        case .plugIn: "PlugIns"
        case .transportManager: "Transport Managers"
        case .box: "Boxes"
        case .device: "Devices"
        case .clock: "Clocks"
        case .endPointDevice: "EndPoint Devices"
        case .endPoint: "EndPoints"
        case .stream: "Streams"

        // MARK: CoreAudio/AudioHardwareBase.h - Controls
        case .control: "Controls"
        case .sliderControl: "Slider Controls"

        // MARK: CoreAudio/AudioHardwareBase.h - Level Controls
        case .levelControl: "Level Controls"
        case .volumeControl: "Volume Controls"
        case .lfeVolumeControl: "LFE Volume Controls"

        // MARK: CoreAudio/AudioHardwareBase.h - Boolean Controls
        case .booleanControl: "Boolean Controls"
        case .muteControl: "Mute Controls"
        case .soloControl: "Solo Controls"
        case .jackControl: "Jack Controls"
        case .lfeMuteControl: "LFE Mute Controls"
        case .phantomPowerControl: "Phantom Power Controls"
        case .phaseInvertControl: "Phase Invert Controls"
        case .clipLightControl: "Clip Light Controls"
        case .talkbackControl: "Talkback Controls"
        case .listenbackControl: "Listenback Controls"

        // MARK: CoreAudio/AudioHardwareBase.h - Selector Controls
        case .selectorControl: "Selector Controls"
        case .dataSourceControl: "Data Source Controls"
        case .dataDestinationControl: "Data Destination Controls"
        case .clockSourceControl: "Clock Source Controls"
        case .lineLevelControl: "Line Level Controls"
        case .highPassFilterControl: "High Pass Filter Controls"

        // MARK: CoreAudio/AudioHardwareBase.h - Stereo Pan Control
        case .stereoPanControl: "Stereo Pan Controls"

        // MARK: CoreAudio/AudioHardware.h
        case .system: "System"
        case .aggregate: "Aggregates"
        case .subdevice: "Subdevices"
        case .subtap: "Subtaps"
        case .process: "Processes"
        case .tap: "Taps"

        // MARK: CoreAudio/AudioHardwareDeprecated.h
        case .iSubOwnerControl: "iSub Owner Controls"
        case .bootChimeVolumeControl: "Boot Chime Volume Controls"
        }
    }

    /// Suggested SF Symbol (system image) name for use in SwiftUI `Image`.
    nonisolated
    public var systemImageName: String {
        switch self {
        // MARK: CoreAudio/AudioHardwareBase.h

        case .wildcard: "asterisk"
        case .object: "square.dashed"
        case .plugIn: "powerplug"
        case .transportManager: "playpause"
        case .box: "archivebox"
        case .device: "hifispeaker"
        case .clock: "clock"
        case .endPointDevice: "hifispeaker.arrow.forward"
        case .endPoint: "arrow.right.square"
        case .stream: "waveform"

        // MARK: CoreAudio/AudioHardwareBase.h - Controls
        case .control: "switch.2"
        case .sliderControl: "switch.2"

        // MARK: CoreAudio/AudioHardwareBase.h - Level Controls
        case .levelControl: "switch.2"
        case .volumeControl: "switch.2"
        case .lfeVolumeControl: "switch.2"

        // MARK: CoreAudio/AudioHardwareBase.h - Boolean Controls
        case .booleanControl: "switch.2"
        case .muteControl: "switch.2"
        case .soloControl: "switch.2"
        case .jackControl: "switch.2"
        case .lfeMuteControl: "switch.2"
        case .phantomPowerControl: "switch.2"
        case .phaseInvertControl: "switch.2"
        case .clipLightControl: "switch.2"
        case .talkbackControl: "switch.2"
        case .listenbackControl: "switch.2"

        // MARK: CoreAudio/AudioHardwareBase.h - Selector Controls
        case .selectorControl: "switch.2"
        case .dataSourceControl: "switch.2"
        case .dataDestinationControl: "switch.2"
        case .clockSourceControl: "switch.2"
        case .lineLevelControl: "switch.2"
        case .highPassFilterControl: "switch.2"

        // MARK: CoreAudio/AudioHardwareBase.h - Stereo Pan Control
        case .stereoPanControl: "switch.2"

        // MARK: CoreAudio/AudioHardware.h
        case .system: "desktopcomputer"
        case .aggregate: "plus.square"
        case .subdevice: "hifispeaker.2"
        case .subtap: "spigot.fill"
        case .process: "apple.terminal"
        case .tap: "spigot"

        // MARK: CoreAudio/AudioHardwareDeprecated.h
        case .iSubOwnerControl: "switch.2"
        case .bootChimeVolumeControl: "switch.2"
        }
    }
}

// MARK: - Concrete Type

extension AudioObjectClassID {
    /// Returns the concrete type associated with the object type.
    nonisolated
    public var concreteType: (any AudioObject.Type)? {
        switch self {
        // MARK: CoreAudio/AudioHardwareBase.h

        case .wildcard: nil
        case .object: nil
        case .plugIn: AudioPlugIn.self
        case .transportManager: AudioTransportManager.self
        case .box: AudioBox.self
        case .device: AudioDevice.self
        case .clock: AudioClock.self
        case .endPointDevice: AudioEndPointDevice.self
        case .endPoint: nil // TODO: add once type is implemented
        case .stream: AudioStream.self

        // MARK: CoreAudio/AudioHardwareBase.h - Controls
        case .control: AudioControl.self
        case .sliderControl: nil // TODO: add once type is implemented

        // MARK: CoreAudio/AudioHardwareBase.h - Level Controls
        case .levelControl: AudioLevelControl.self
        case .volumeControl: nil // TODO: add once type is implemented
        case .lfeVolumeControl: nil // TODO: add once type is implemented

        // MARK: CoreAudio/AudioHardwareBase.h - Boolean Controls
        case .booleanControl: AudioBooleanControl.self
        case .muteControl: nil // TODO: add once type is implemented
        case .soloControl: nil // TODO: add once type is implemented
        case .jackControl: nil // TODO: add once type is implemented
        case .lfeMuteControl: nil // TODO: add once type is implemented
        case .phantomPowerControl: nil // TODO: add once type is implemented
        case .phaseInvertControl: nil // TODO: add once type is implemented
        case .clipLightControl: nil // TODO: add once type is implemented
        case .talkbackControl: nil // TODO: add once type is implemented
        case .listenbackControl: nil // TODO: add once type is implemented

        // MARK: CoreAudio/AudioHardwareBase.h - Selector Controls
        case .selectorControl: nil // TODO: add once type is implemented
        case .dataSourceControl: nil // TODO: add once type is implemented
        case .dataDestinationControl: nil // TODO: add once type is implemented
        case .clockSourceControl: nil // TODO: add once type is implemented
        case .lineLevelControl: nil // TODO: add once type is implemented
        case .highPassFilterControl: nil // TODO: add once type is implemented

        // MARK: CoreAudio/AudioHardwareBase.h - Stereo Pan Control
        case .stereoPanControl: AudioStereoPanControl.self

        // MARK: CoreAudio/AudioHardware.h
        case .system: AudioSystem.self
        case .aggregate: AudioAggregateDevice.self
        case .subdevice: AudioSubDevice.self
        case .subtap: AudioSubTap.self
        case .process: AudioProcess.self
        case .tap: AudioTap.self

        // MARK: CoreAudio/AudioHardwareDeprecated.h
        case .iSubOwnerControl: nil // TODO: add once type is implemented
        case .bootChimeVolumeControl: nil // TODO: add once type is implemented
        }
    }
}

#endif
