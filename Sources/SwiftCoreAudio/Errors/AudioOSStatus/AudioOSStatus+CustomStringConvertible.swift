//
//  AudioOSStatus+CustomStringConvertible.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

extension AudioOSStatus: CustomStringConvertible {
    public var description: String {
        "\(constantDescription) (\(constantName))"
    }
}

extension AudioOSStatus {
    // TODO: Make these localized strings, allowing future localizations.

    /// Returns a human-readable description of the constant.
    public var constantDescription: String {
        switch self {
        // MARK: CoreAudio/AudioHardwareBase.h

        case .noError: "No error occurred."
        case .notRunning: "The audio hardware is not running."
        case .unspecifiedError: "An unspecified error occurred."
        case .unknownProperty: "Attempt to query an unknown property."
        case .badPropertySize: "An improperly sized buffer was provided when accessing the data of a property."
        case .illegalOperation: "The requested operation couldn't be completed."
        case .badObject: "The audio object does not exist."
        case .badDevice: "The audio device does not exist."
        case .badStream: "The audio stream does not exist."
        case .unsupportedOperation: "The operation is not supported by the audio object."
        case .notReady: "The audio object is not ready."
        case .unsupportedFormat: "The stream format is unsupported."
        case .permissionsError: "The process doesn't have permission."

        // MARK: CoreAudioTypes/CoreAudioBaseTypes.h
        case .unimplemented: "Unimplemented."
        case .fileNotFound: "File not found."
        case .filePermission: "File permission error."
        case .tooManyFilesOpen: "Too many files open."
        case .badFilePath: "Bad file path."
        case .paramError: "Parameter error."
        case .memFull: "Memory full."

        // MARK: AudioToolkit/AUComponent.h
        case .invalidProperty: "The property is not supported."
        case .invalidParameter: "The parameter is not supported."
        case .invalidElement: "The specified element is not valid."
        case .noConnection: "There is no connection."
        case .failedInitialization: "The audio unit is unable to be initialized."
        case .tooManyFramesToProcess: "Too many frames to process."
        case .invalidFile: "Invalid file."
        case .unknownFileType: "If an audio unit uses external files as a data source, this error is returned"
        case .fileNotSpecified: "If an audio unit uses external files as a data source, this error is returned"
        case .formatNotSupported: "Format not supported."
        case .uninitialized: "Uninitialized."
        case .invalidScope: "The specified scope is invalid."
        case .propertyNotWritable: "The property cannot be written."
        case .cannotDoInCurrentContext: "Cannot do in current context."
        case .invalidPropertyValue: "Invalid property value."
        case .propertyNotInUse: "Property not in use."
        case .initialized: "(Already) Initialized."
        case .invalidOfflineRender: "Invalid offline render."
        case .unauthorized: "Unauthorized."
        case .midiOutputBufferFull: "MIDI output buffer full."
        case .instanceTimedOut: "Instance timed out."
        case .instanceInvalidated: "Instance invalidated."
        case .renderTimeout: "Render timeout."
        case .extensionNotFound: "The specified identifier did not match any Audio Unit Extensions."
        case .invalidParameterValue: "Invalid parameter value."
        case .invalidFilePath: "Invalid file path."
        case .missingKey: "Missing key."
        case .componentManagerNotSupported: "Component manager not supported."
        case .multipleVoiceProcessors: "Multiple voice processors."

        // MARK: AudioToolkit/AUComponent.h - Inter-App Audio
        case .duplicateDescription: "Duplicate description."
        case .unsupportedType: "Unsupported type."
        case .tooManyInstances: "Too many instances."
        case .notPermitted: "Not permitted."
        case .initializationTimedOut: "Initialization timed out."
        case .invalidFormat: "Invalid format."

        // MARK: AudioToolkit/AUComponent.h - Deprecated
        case .illegalInstrument: "Illegal instrument."
        case .instrumentTypeNotFound: "Instrument type not found."

        // MARK: AudioToolkit/AudioCodec.h
        case .stateError: "The codec is in an invalid state."
        case .notEnoughBufferSpace: "Not enough buffer space available."
        case .badData: "Bad codec data."
        }
    }

    /// Returns the constant symbol name. Useful for debugging.
    public var constantName: String {
        switch self {
        // MARK: CoreAudio/AudioHardwareBase.h

        case .noError: "kAudioHardwareNoError"
        case .notRunning: "kAudioHardwareNotRunningError"
        case .unspecifiedError: "kAudioHardwareUnspecifiedError"
        case .unknownProperty: "kAudioHardwareUnknownPropertyError"
        case .badPropertySize: "kAudioHardwareBadPropertySizeError"
        case .illegalOperation: "kAudioHardwareIllegalOperationError"
        case .badObject: "kAudioHardwareBadObjectError"
        case .badDevice: "kAudioHardwareBadDeviceError"
        case .badStream: "kAudioHardwareBadStreamError"
        case .unsupportedOperation: "kAudioHardwareUnsupportedOperationError"
        case .notReady: "kAudioHardwareNotReadyError"
        case .unsupportedFormat: "kAudioDeviceUnsupportedFormatError"
        case .permissionsError: "kAudioDevicePermissionsError"

        // MARK: CoreAudioTypes/CoreAudioBaseTypes.h
        case .unimplemented: "kAudio_UnimplementedError"
        case .fileNotFound: "kAudio_FileNotFoundError"
        case .filePermission: "kAudio_FilePermissionError"
        case .tooManyFilesOpen: "kAudio_TooManyFilesOpenError"
        case .badFilePath: "kAudio_BadFilePathError"
        case .paramError: "kAudio_ParamError"
        case .memFull: "kAudio_MemFullError"

        // MARK: AudioToolkit/AUComponent.h
        case .invalidProperty: "kAudioUnitErr_InvalidProperty"
        case .invalidParameter: "kAudioUnitErr_InvalidParameter"
        case .invalidElement: "kAudioUnitErr_InvalidElement"
        case .noConnection: "kAudioUnitErr_NoConnection"
        case .failedInitialization: "kAudioUnitErr_FailedInitialization"
        case .tooManyFramesToProcess: "kAudioUnitErr_TooManyFramesToProcess"
        case .invalidFile: "kAudioUnitErr_InvalidFile"
        case .unknownFileType: "kAudioUnitErr_UnknownFileType"
        case .fileNotSpecified: "kAudioUnitErr_FileNotSpecified"
        case .formatNotSupported: "kAudioUnitErr_FormatNotSupported"
        case .uninitialized: "kAudioUnitErr_Uninitialized"
        case .invalidScope: "kAudioUnitErr_InvalidScope"
        case .propertyNotWritable: "kAudioUnitErr_PropertyNotWritable"
        case .cannotDoInCurrentContext: "kAudioUnitErr_CannotDoInCurrentContext"
        case .invalidPropertyValue: "kAudioUnitErr_InvalidPropertyValue"
        case .propertyNotInUse: "kAudioUnitErr_PropertyNotInUse"
        case .initialized: "kAudioUnitErr_Initialized"
        case .invalidOfflineRender: "kAudioUnitErr_InvalidOfflineRender"
        case .unauthorized: "kAudioUnitErr_Unauthorized"
        case .midiOutputBufferFull: "kAudioUnitErr_MIDIOutputBufferFull"
        case .instanceTimedOut: "kAudioComponentErr_InstanceTimedOut"
        case .instanceInvalidated: "kAudioComponentErr_InstanceInvalidated"
        case .renderTimeout: "kAudioUnitErr_RenderTimeout"
        case .extensionNotFound: "kAudioUnitErr_ExtensionNotFound"
        case .invalidParameterValue: "kAudioUnitErr_InvalidParameterValue"
        case .invalidFilePath: "kAudioUnitErr_InvalidFilePath"
        case .missingKey: "kAudioUnitErr_MissingKey"
        case .componentManagerNotSupported: "kAudioUnitErr_ComponentManagerNotSupported"
        case .multipleVoiceProcessors: "kAudioUnitErr_MultipleVoiceProcessors"

        // MARK: AudioToolkit/AUComponent.h - Inter-App Audio
        case .duplicateDescription: "kAudioComponentErr_DuplicateDescription"
        case .unsupportedType: "kAudioComponentErr_UnsupportedType"
        case .tooManyInstances: "kAudioComponentErr_TooManyInstances"
        case .notPermitted: "kAudioComponentErr_NotPermitted"
        case .initializationTimedOut: "kAudioComponentErr_InitializationTimedOut"
        case .invalidFormat: "kAudioComponentErr_InvalidFormat"

        // MARK: AudioToolkit/AUComponent.h - Deprecated
        case .illegalInstrument: "kAudioUnitErr_IllegalInstrument"
        case .instrumentTypeNotFound: "kAudioUnitErr_InstrumentTypeNotFound"

        // MARK: AudioToolkit/AudioCodec.h
        case .stateError: "kAudioCodecStateError"
        case .notEnoughBufferSpace: "kAudioCodecNotEnoughBufferSpaceError"
        case .badData: "kAudioCodecBadDataError"
        }
    }
}
