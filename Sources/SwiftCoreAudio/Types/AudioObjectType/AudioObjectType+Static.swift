//
//  AudioObjectType+Static.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

// MARK: CoreAudio/AudioHardwareBase.h

// `wildcard` does not exist as a concrete object type

// `object` does not exist as a concrete object type, as it corresponds to the `AudioObject` protocol

extension AudioObjectType where Self == AudioObjectConcreteType<AudioPlugIn> {
    /// The concrete type corresponding to the `AudioPlugIn` class.
    public static var plugIn: Self {
        .init(classID: .plugIn)
    }
}

extension AudioObjectType where Self == AudioObjectConcreteType<AudioTransportManager> {
    /// The concrete type corresponding to the `AudioTransportManager` class.
    public static var transportManager: Self {
        .init(classID: .transportManager)
    }
}

extension AudioObjectType where Self == AudioObjectConcreteType<AudioBox> {
    /// The concrete type corresponding to the `AudioBox` class.
    public static var box: Self {
        .init(classID: .box)
    }
}

extension AudioObjectType where Self == AudioObjectConcreteType<AudioDevice> {
    /// The concrete type corresponding to the `AudioDevice` class.
    public static var device: Self {
        .init(classID: .device)
    }
}

extension AudioObjectType where Self == AudioObjectConcreteType<AudioClock> {
    /// The concrete type corresponding to the `AudioClockDevice` class.
    public static var clock: Self {
        .init(classID: .clock)
    }
}

extension AudioObjectType where Self == AudioObjectConcreteType<AudioEndPointDevice> {
    /// The concrete type corresponding to the `AudioEndPointDevice` class.
    public static var endPointDevice: Self {
        .init(classID: .endPointDevice)
    }
}

// TODO: replace `AnyAudioObject` with type name after concrete type is implemented
extension AudioObjectType where Self == AudioObjectConcreteType<AnyAudioObject> {
    /// The concrete type corresponding to the `AudioEndPoint` class.
    public static var endPoint: Self {
        .init(classID: .endPoint)
    }
}

extension AudioObjectType where Self == AudioObjectConcreteType<AudioStream> {
    /// The concrete type corresponding to the `AudioStream` class.
    public static var stream: Self {
        .init(classID: .stream)
    }
}

// MARK: CoreAudio/AudioHardwareBase.h - Controls

extension AudioObjectType where Self == AudioObjectConcreteType<AudioControl> {
    /// The concrete type corresponding to the `AudioControl` class.
    public static var control: Self {
        .init(classID: .control)
    }
}

// TODO: replace `AnyAudioObject` with type name after concrete type is implemented
extension AudioObjectType where Self == AudioObjectConcreteType<AnyAudioObject> {
    /// The concrete type corresponding to the `AudioSliderControl` class.
    public static var sliderControl: Self {
        .init(classID: .sliderControl)
    }
}

// MARK: CoreAudio/AudioHardwareBase.h - Level Controls

extension AudioObjectType where Self == AudioObjectConcreteType<AudioLevelControl> {
    /// The concrete type corresponding to the `AudioLevelControl` class.
    public static var levelControl: Self {
        .init(classID: .levelControl)
    }
}

// TODO: replace `AnyAudioObject` with type name after concrete type is implemented
extension AudioObjectType where Self == AudioObjectConcreteType<AnyAudioObject> {
    /// The concrete type corresponding to the `AudioVolumeControl` class.
    ///
    /// A subclass of the `AudioLevelControl` class that implements a general
    /// gain/attenuation stage.
    public static var volumeControl: Self {
        .init(classID: .volumeControl)
    }
 }

// TODO: replace `AnyAudioObject` with type name after concrete type is implemented
extension AudioObjectType where Self == AudioObjectConcreteType<AnyAudioObject> {
    /// A subclass of the `AudioLevelControl` class for an LFE channel that results from
    /// bass management.
    ///
    /// Note that LFE channels that are represented as normal audio channels must use
    /// `kAudioVolumeControlClassID` (``volumeControl``) to manipulate the level.
    public static var lfeVolumeControl: Self {
        .init(classID: .lfeVolumeControl)
    }
}

// MARK: CoreAudio/AudioHardwareBase.h - Boolean Controls

extension AudioObjectType where Self == AudioObjectConcreteType<AudioBooleanControl> {
    /// The concrete type corresponding to the `AudioBooleanControl` class.
    public static var booleanControl: Self {
        .init(classID: .booleanControl)
    }
}

// TODO: replace `AnyAudioObject` with type name after concrete type is implemented
extension AudioObjectType where Self == AudioObjectConcreteType<AnyAudioObject> {
    /// A subclass of the `AudioBooleanControl` class where a `true` value means that
    /// mute is enabled making that element inaudible.
    public static var muteControl: Self {
        .init(classID: .muteControl)
    }
}

// TODO: replace `AnyAudioObject` with type name after concrete type is implemented
extension AudioObjectType where Self == AudioObjectConcreteType<AnyAudioObject> {
    /// A subclass of the `AudioBooleanControl` class where a `true` value means that
    /// solo is enabled, making just that element audible and the other elements
    /// inaudible.
    public static var soloControl: Self {
        .init(classID: .soloControl)
    }
}

// TODO: replace `AnyAudioObject` with type name after concrete type is implemented
extension AudioObjectType where Self == AudioObjectConcreteType<AnyAudioObject> {
    /// A subclass of the `AudioBooleanControl` class where a `true` value means
    /// something is plugged into that element.
    public static var jackControl: Self {
        .init(classID: .jackControl)
    }
}

// TODO: replace `AnyAudioObject` with type name after concrete type is implemented
extension AudioObjectType where Self == AudioObjectConcreteType<AnyAudioObject> {
    /// A subclass of the `AudioBooleanControl` class where `true` means that mute is
    /// enabled making that LFE element inaudible.
    ///
    /// This control is for LFE channels that result from bass management.
    ///
    /// Note that LFE channels that are represented as normal audio channels must use an
    /// `AudioMuteControl`.
    public static var lfeMuteControl: Self {
        .init(classID: .lfeMuteControl)
    }
}

// TODO: replace `AnyAudioObject` with type name after concrete type is implemented
extension AudioObjectType where Self == AudioObjectConcreteType<AnyAudioObject> {
    /// A subclass of the `AudioBooleanControl` class where `true` means that the
    /// element's hardware has phantom power enabled.
    public static var phantomPowerControl: Self {
        .init(classID: .phantomPowerControl)
    }
}

// TODO: replace `AnyAudioObject` with type name after concrete type is implemented
extension AudioObjectType where Self == AudioObjectConcreteType<AnyAudioObject> {
    /// A subclass of the `AudioBooleanControl` class where `true` means that the phase
    /// of the signal on the given element is being inverted by 180 degrees.
    public static var phaseInvertControl: Self {
        .init(classID: .phaseInvertControl)
    }
}

// TODO: replace `AnyAudioObject` with type name after concrete type is implemented
extension AudioObjectType where Self == AudioObjectConcreteType<AnyAudioObject> {
    /// A subclass of the `AudioBooleanControl` class where `true` means that the signal
    /// for the element has exceeded the sample range.
    ///
    /// Once a clip light is turned on, it is to stay on until either the value of the control is
    /// set to `false` or the current IO session stops and a new IO session starts.
    public static var clipLightControl: Self {
        .init(classID: .clipLightControl)
    }
}

// TODO: replace `AnyAudioObject` with type name after concrete type is implemented
extension AudioObjectType where Self == AudioObjectConcreteType<AnyAudioObject> {
    /// An `AudioBooleanControl` where `true` means that the talkback channel is
    /// enabled.
    ///
    /// This control is for talkback channels that are handled outside of the regular IO channels.
    /// If the talkback channel is among the normal IO channels, it will use `AudioMuteControl`.
    public static var talkbackControl: Self {
        .init(classID: .talkbackControl)
    }
}

// TODO: replace `AnyAudioObject` with type name after concrete type is implemented
extension AudioObjectType where Self == AudioObjectConcreteType<AnyAudioObject> {
    /// An `AudioBooleanControl` where `true` means that the listenback channel is
    /// audible.
    ///
    /// This control is for listenback channels that are handled outside of the regular IO channels.
    /// If the listenback channel is among the normal IO channels, it will use `AudioMuteControl`.
    public static var listenbackControl: Self {
        .init(classID: .listenbackControl)
    }
}

// MARK: CoreAudio/AudioHardwareBase.h - Selector Controls

extension AudioObjectType where Self == AudioObjectConcreteType<AudioSelectorControl> {
    /// The concrete type corresponding to the `AudioSelectorControl` class.
    public static var selectorControl: Self {
        .init(classID: .selectorControl)
    }
}

// TODO: replace `AnyAudioObject` with type name after concrete type is implemented
extension AudioObjectType where Self == AudioObjectConcreteType<AnyAudioObject> {
    /// A subclass of the `AudioSelectorControl` class that identifies where the data
    /// for the element is coming from.
    public static var dataSourceControl: Self {
        .init(classID: .dataSourceControl)
    }
}

// TODO: replace `AnyAudioObject` with type name after concrete type is implemented
extension AudioObjectType where Self == AudioObjectConcreteType<AnyAudioObject> {
    /// A subclass of the `AudioSelectorControl` class that identifies where the data
    /// for the element is going.
    public static var dataDestinationControl: Self {
        .init(classID: .dataDestinationControl)
    }
}

// TODO: replace `AnyAudioObject` with type name after concrete type is implemented
extension AudioObjectType where Self == AudioObjectConcreteType<AnyAudioObject> {
    /// A subclass of the `AudioSelectorControl` class that identifies where the
    /// timing info for the object is coming from.
    public static var clockSourceControl: Self {
        .init(classID: .clockSourceControl)
    }
}

// TODO: replace `AnyAudioObject` with type name after concrete type is implemented
extension AudioObjectType where Self == AudioObjectConcreteType<AnyAudioObject> {
    /// A subclass of the `AudioSelectorControl` class that identifies the nominal
    /// line level for the element.
    ///
    /// Note that this is not a gain stage but rather indicating the voltage standard (if any)
    /// used for the element, such as +4dBu, -10dBV, instrument, etc.
    public static var lineLevelControl: Self {
        .init(classID: .lineLevelControl)
    }
}

// TODO: replace `AnyAudioObject` with type name after concrete type is implemented
extension AudioObjectType where Self == AudioObjectConcreteType<AnyAudioObject> {
    /// A subclass of the `AudioSelectorControl` class that indicates the setting for
    /// the high pass filter on the given element.
    public static var highPassFilterControl: Self {
        .init(classID: .highPassFilterControl)
    }
}

// MARK: CoreAudio/AudioHardwareBase.h - Stereo Pan Control

extension AudioObjectType where Self == AudioObjectConcreteType<AudioStereoPanControl> {
    /// The concrete type corresponding to the `AudioStereoPanControl` class.
    public static var stereoPanControl: Self {
        .init(classID: .stereoPanControl)
    }
}

// MARK: CoreAudio/AudioHardware.h

extension AudioObjectType where Self == AudioObjectConcreteType<AudioSystem> {
    /// The concrete type corresponding to the `AudioSystemObject` class.
    public static var system: Self {
        .init(classID: .system)
    }
}

extension AudioObjectType where Self == AudioObjectConcreteType<AudioAggregateDevice> {
    /// The concrete type corresponding to the `AudioAggregateDevice` class.
    public static var aggregate: Self {
        .init(classID: .aggregate)
    }
}

extension AudioObjectType where Self == AudioObjectConcreteType<AudioSubDevice> {
    /// The concrete type corresponding to the `AudioSubDevice` class.
    public static var subdevice: Self {
        .init(classID: .subdevice)
    }
}

extension AudioObjectType where Self == AudioObjectConcreteType<AudioSubTap> {
    /// The concrete type corresponding to the `AudioSubTap` class.
    public static var subtap: Self {
        .init(classID: .subtap)
    }
}

extension AudioObjectType where Self == AudioObjectConcreteType<AudioProcess> {
    /// The concrete type corresponding to the `AudioProcess` class.
    public static var process: Self {
        .init(classID: .process)
    }
}

extension AudioObjectType where Self == AudioObjectConcreteType<AudioTap> {
    /// The concrete type corresponding to the `AudioTap` class.
    public static var tap: Self {
        .init(classID: .tap)
    }
}

// MARK: CoreAudio/AudioHardwareDeprecated.h

// TODO: replace `AnyAudioObject` with type name after concrete type is implemented
extension AudioObjectType where Self == AudioObjectConcreteType<AnyAudioObject> {
    /// A subclass of the `AudioBooleanControl` where `true` means that the `AudioDevice` that
    /// ultimately owns the control also owns any iSub attached to the CPU.
    public static var iSubOwnerControl: Self {
        .init(classID: .iSubOwnerControl)
    }
}

// TODO: replace `AnyAudioObject` with type name after concrete type is implemented
extension AudioObjectType where Self == AudioObjectConcreteType<AnyAudioObject> {
    /// A subclass of the `AudioLevelControl` class for the boot chime of the CPU.
    public static var bootChimeVolumeControl: Self {
        .init(classID: .bootChimeVolumeControl)
    }
}

#endif
