//
//  OSStatus+Multiplatform.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

// Provide constants on platforms where they are missing.

#if (os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)) && !targetEnvironment(macCatalyst)

// MARK: CoreAudio/AudioHardwareBase.h

let kAudioHardwareNoError: OSStatus = 0
let kAudioHardwareNotRunningError: OSStatus = osStatus(fourCharCode: "stop")
let kAudioHardwareUnspecifiedError: OSStatus = osStatus(fourCharCode: "what")
let kAudioHardwareUnknownPropertyError: OSStatus = osStatus(fourCharCode: "who?")
let kAudioHardwareBadPropertySizeError: OSStatus = osStatus(fourCharCode: "!siz")
let kAudioHardwareIllegalOperationError: OSStatus = osStatus(fourCharCode: "nope")
let kAudioHardwareBadObjectError: OSStatus = osStatus(fourCharCode: "!obj")
let kAudioHardwareBadDeviceError: OSStatus = osStatus(fourCharCode: "!dev")
let kAudioHardwareBadStreamError: OSStatus = osStatus(fourCharCode: "!str")
let kAudioHardwareUnsupportedOperationError: OSStatus = osStatus(fourCharCode: "unop")
let kAudioHardwareNotReadyError: OSStatus = osStatus(fourCharCode: "nrdy")
let kAudioDeviceUnsupportedFormatError: OSStatus = osStatus(fourCharCode: "!dat")
let kAudioDevicePermissionsError: OSStatus = osStatus(fourCharCode: "!hog")

#endif

#if os(watchOS)

// MARK: AudioToolkit/AUComponent.h

let kAudioUnitErr_InvalidProperty: OSStatus = -10879
let kAudioUnitErr_InvalidParameter: OSStatus = -10878
let kAudioUnitErr_InvalidElement: OSStatus = -10877
let kAudioUnitErr_NoConnection: OSStatus = -10876
let kAudioUnitErr_FailedInitialization: OSStatus = -10875
let kAudioUnitErr_TooManyFramesToProcess: OSStatus = -10874
let kAudioUnitErr_InvalidFile: OSStatus = -10871
let kAudioUnitErr_UnknownFileType: OSStatus = -10870
let kAudioUnitErr_FileNotSpecified: OSStatus = -10869
let kAudioUnitErr_FormatNotSupported: OSStatus = -10868
let kAudioUnitErr_Uninitialized: OSStatus = -10867
let kAudioUnitErr_InvalidScope: OSStatus = -10866
let kAudioUnitErr_PropertyNotWritable: OSStatus = -10865
let kAudioUnitErr_CannotDoInCurrentContext: OSStatus = -10863
let kAudioUnitErr_InvalidPropertyValue: OSStatus = -10851
let kAudioUnitErr_PropertyNotInUse: OSStatus = -10850
let kAudioUnitErr_Initialized: OSStatus = -10849
let kAudioUnitErr_InvalidOfflineRender: OSStatus = -10848
let kAudioUnitErr_Unauthorized: OSStatus = -10847
let kAudioUnitErr_MIDIOutputBufferFull: OSStatus = -66753
let kAudioComponentErr_InstanceTimedOut: OSStatus = -66754
let kAudioComponentErr_InstanceInvalidated: OSStatus = -66749
let kAudioUnitErr_RenderTimeout: OSStatus = -66745
let kAudioUnitErr_ExtensionNotFound: OSStatus = -66744
let kAudioUnitErr_InvalidParameterValue: OSStatus = -66743
let kAudioUnitErr_InvalidFilePath: OSStatus = -66742
let kAudioUnitErr_MissingKey: OSStatus = -66741
let kAudioUnitErr_ComponentManagerNotSupported: OSStatus = -66740
let kAudioUnitErr_MultipleVoiceProcessors: OSStatus = -66635

// MARK: AudioToolkit/AUComponent.h - Inter-App Audio

let kAudioComponentErr_DuplicateDescription: OSStatus = -66752
let kAudioComponentErr_UnsupportedType: OSStatus = -66751
let kAudioComponentErr_TooManyInstances: OSStatus = -66750
let kAudioComponentErr_NotPermitted: OSStatus = -66748
let kAudioComponentErr_InitializationTimedOut: OSStatus = -66747
let kAudioComponentErr_InvalidFormat: OSStatus = -66746

// MARK: AudioToolkit/AUComponent.h - Deprecated

let kAudioUnitErr_IllegalInstrument: OSStatus = -10873
let kAudioUnitErr_InstrumentTypeNotFound: OSStatus = -10872

// MARK: AudioToolkit/AudioCodec.h

let kAudioCodecStateError: OSStatus = osStatus(fourCharCode: "!stt")
let kAudioCodecNotEnoughBufferSpaceError: OSStatus = osStatus(fourCharCode: "!buf")
let kAudioCodecBadDataError: OSStatus = osStatus(fourCharCode: "bada")

#endif
