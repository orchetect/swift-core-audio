//
//  AudioOSStatus.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if !os(watchOS)
import AudioToolbox
#endif

import CoreAudio
import Foundation

// swiftformat:disable numberFormatting

/// An enumeration of known `OSStatus` codes returned by CoreAudio and AudioToolkit.
public enum AudioOSStatus {
    // MARK: CoreAudio/AudioHardwareBase.h

    // The error constants unique to the HAL.
    //
    // These are the error constants that are unique to the HAL. Note that the HAL's
    // functions can and will return other codes that are not listed here. While these
    // constants give a general idea of what might have gone wrong during the execution
    // of an API call, if an API call returns anything other than kAudioHardwareNoError
    // it is to be viewed as the same failure regardless of what constant is actually
    // returned.
    //
    // kAudioHardwareNoError                   = 0
    // kAudioHardwareNotRunningError           = 'stop'
    // kAudioHardwareUnspecifiedError          = 'what'
    // kAudioHardwareUnknownPropertyError      = 'who?'
    // kAudioHardwareBadPropertySizeError      = '!siz'
    // kAudioHardwareIllegalOperationError     = 'nope'
    // kAudioHardwareBadObjectError            = '!obj'
    // kAudioHardwareBadDeviceError            = '!dev'
    // kAudioHardwareBadStreamError            = '!str'
    // kAudioHardwareUnsupportedOperationError = 'unop'
    // kAudioHardwareNotReadyError             = 'nrdy'
    // kAudioDeviceUnsupportedFormatError      = '!dat'
    // kAudioDevicePermissionsError            = '!hog'
    
    /// The function call completed successfully. (No error occurred.)
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioHardwareNoError`
    case noError

    /// The audio hardware is not running.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioHardwareNotRunningError`
    case notRunning
    
    /// An unspecified error occurred.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioHardwareUnspecifiedError`
    case unspecifiedError
    
    /// Attempt to query an unknown property.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioHardwareUnknownPropertyError`
    case unknownProperty
    
    /// An improperly sized buffer was provided when accessing the data of a property.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioHardwareBadPropertySizeError`
    case badPropertySize
    
    /// An illegal operation was attempted (The requested operation couldn't be completed).
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioHardwareIllegalOperationError`
    case illegalOperation
    
    /// The audio object does not exist.
    ///
    /// The `AudioObjectID` passed to the function doesn't map to a valid `AudioObject`.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioHardwareBadObjectError`
    case badObject
    
    /// The audio device does not exist.
    ///
    /// The `AudioObjectID` passed to the function doesn't map to a valid `AudioDevice`.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioHardwareBadDeviceError`
    case badDevice
    
    /// The audio stream does not exist.
    ///
    /// The AudioObjectID passed to the function doesn't map to a valid AudioStream.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioHardwareBadStreamError`
    case badStream
    
    /// The operation is not supported by the audio object.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioHardwareUnsupportedOperationError`
    case unsupportedOperation
    
    /// The audio object is not ready.
    ///
    /// The `AudioObject` isn't ready to do the requested operation.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioHardwareNotReadyError`
    case notReady
    
    /// The stream format is unsupported.
    ///
    /// The `AudioStream` doesn't support the requested format.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioDeviceUnsupportedFormatError`
    case unsupportedFormat
    
    /// The requested operation can't be completed because the process doesn't have permission.
    ///
    /// May be returned when the app does not have microphone or system audio permission.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioDevicePermissionsError`
    case permissionsError

    // MARK: CoreAudioTypes/CoreAudioBaseTypes.h
    
    // kAudio_NoError               = 0,      // duplicate of a kAudioHardware constant
    // kAudio_UnimplementedError    = -4,
    // kAudio_FileNotFoundError     = -43,
    // kAudio_FilePermissionError   = -54,
    // kAudio_TooManyFilesOpenError = -42,
    // kAudio_BadFilePathError      = '!pth', // 0x21707468, 561017960
    // kAudio_ParamError            = -50,
    // kAudio_MemFullError          = -108
    
    /// Unimplemented.
    ///
    /// Unimplemented core routine.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudio_UnimplementedError`
    case unimplemented
    
    /// File not found.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudio_FileNotFoundError`
    case fileNotFound
    
    /// File permission error.
    ///
    /// File cannot be opened due to either file, directory, or sandbox permissions.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudio_FilePermissionError`
    case filePermission
    
    /// Too many files open.
    ///
    /// File cannot be opened because too many files are already open.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudio_TooManyFilesOpenError`
    case tooManyFilesOpen
    
    /// Bad file path.
    ///
    /// File cannot be opened because the specified path is malformed.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudio_BadFilePathError`
    case badFilePath
    
    /// Parameter error.
    ///
    /// Error in user parameter list.
    ///
    /// > Tip:
    /// > Can be a result of trying to render audio in `AudioUnit`s following a CoreAudio crash.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudio_ParamError`
    case paramError
    
    /// Memory full.
    ///
    /// Not enough room in heap zone.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudio_MemFullError`
    case memFull
    
    // MARK: AudioToolkit/AUComponent.h
    
    // Audio unit errors
    //
    // These are the various errors that can be returned by AudioUnit API calls
    //
    // kAudioUnitErr_InvalidProperty              = -10879
    // kAudioUnitErr_InvalidParameter             = -10878
    // kAudioUnitErr_InvalidElement               = -10877
    // kAudioUnitErr_NoConnection                 = -10876
    // kAudioUnitErr_FailedInitialization         = -10875
    // kAudioUnitErr_TooManyFramesToProcess       = -10874
    // kAudioUnitErr_InvalidFile                  = -10871
    // kAudioUnitErr_UnknownFileType              = -10870
    // kAudioUnitErr_FileNotSpecified             = -10869
    // kAudioUnitErr_FormatNotSupported           = -10868
    // kAudioUnitErr_Uninitialized                = -10867
    // kAudioUnitErr_InvalidScope                 = -10866
    // kAudioUnitErr_PropertyNotWritable          = -10865
    // kAudioUnitErr_CannotDoInCurrentContext     = -10863
    // kAudioUnitErr_InvalidPropertyValue         = -10851
    // kAudioUnitErr_PropertyNotInUse             = -10850
    // kAudioUnitErr_Initialized                  = -10849
    // kAudioUnitErr_InvalidOfflineRender         = -10848
    // kAudioUnitErr_Unauthorized                 = -10847
    // kAudioUnitErr_MIDIOutputBufferFull         = -66753
    // kAudioComponentErr_InstanceTimedOut        = -66754
    // kAudioComponentErr_InstanceInvalidated     = -66749
    // kAudioUnitErr_RenderTimeout                = -66745
    // kAudioUnitErr_ExtensionNotFound            = -66744
    // kAudioUnitErr_InvalidParameterValue        = -66743
    // kAudioUnitErr_InvalidFilePath              = -66742
    // kAudioUnitErr_MissingKey                   = -66741
    // kAudioUnitErr_ComponentManagerNotSupported = -66740
    // kAudioUnitErr_MultipleVoiceProcessors      = -66635
    
    /// The property is not supported.
    ///
    /// > File: AudioToolkit/AUComponent.h
    ///
    /// > Constant: `kAudioUnitErr_InvalidProperty`
    case invalidProperty
    
    /// The parameter is not supported.
    ///
    /// > File: AudioToolkit/AUComponent.h
    ///
    /// > Constant: `kAudioUnitErr_InvalidParameter`
    case invalidParameter
    
    /// The specified element is not valid.
    ///
    /// > File: AudioToolkit/AUComponent.h
    ///
    /// > Constant: `kAudioUnitErr_InvalidElement`
    case invalidElement
    
    /// There is no connection.
    ///
    /// Generally an audio unit is asked to render but it has not input from which to gather data.
    ///
    /// > File: AudioToolkit/AUComponent.h
    ///
    /// > Constant: `kAudioUnitErr_NoConnection`
    case noConnection
    
    /// The audio unit is unable to be initialized.
    ///
    /// > File: AudioToolkit/AUComponent.h
    ///
    /// > Constant: `kAudioUnitErr_FailedInitialization`
    case failedInitialization
    
    /// Too many frames to process.
    ///
    /// When an audio unit is initialized it has a value which specifies the max number of frames
    /// it will be asked to render at any given time.
    ///
    /// If an audio unit is asked to render more than this, this error is returned.
    ///
    /// > File: AudioToolkit/AUComponent.h
    ///
    /// > Constant: `kAudioUnitErr_TooManyFramesToProcess`
    case tooManyFramesToProcess
    
    /// Invalid file.
    ///
    /// If an audio unit uses external files as a data source, this error is returned
    /// if a file is invalid.
    ///
    /// Apple's DLS synth returns this error.
    ///
    /// > File: AudioToolkit/AUComponent.h
    ///
    /// > Constant: `kAudioUnitErr_InvalidFile`
    case invalidFile
    
    /// If an audio unit uses external files as a data source, this error is returned
    /// if a file is invalid.
    ///
    /// Apple's DLS synth returns this error.
    ///
    /// > File: AudioToolkit/AUComponent.h
    ///
    /// > Constant: `kAudioUnitErr_UnknownFileType`
    case unknownFileType
    
    /// If an audio unit uses external files as a data source, this error is returned
    /// if a file hasn't been set on it.
    ///
    /// Apple's DLS synth returns this error.
    ///
    /// > File: AudioToolkit/AUComponent.h
    ///
    /// > Constant: `kAudioUnitErr_FileNotSpecified`
    case fileNotSpecified
    
    /// Format not supported.
    ///
    /// Returned if an input or output format is not supported.
    ///
    /// > File: AudioToolkit/AUComponent.h
    ///
    /// > Constant: `kAudioUnitErr_FormatNotSupported`
    case formatNotSupported
    
    /// Uninitialized.
    ///
    /// Returned if an operation requires an audio unit to be initialized and it is not.
    ///
    /// > File: AudioToolkit/AUComponent.h
    ///
    /// > Constant: `kAudioUnitErr_Uninitialized`
    case uninitialized
    
    /// The specified scope is invalid.
    ///
    /// > File: AudioToolkit/AUComponent.h
    ///
    /// > Constant: `kAudioUnitErr_InvalidScope`
    case invalidScope
    
    /// The property cannot be written.
    ///
    /// > File: AudioToolkit/AUComponent.h
    ///
    /// > Constant: `kAudioUnitErr_PropertyNotWritable`
    case propertyNotWritable
    
    /// Cannot do in current context.
    ///
    /// Returned when an audio unit is in a state where it can't perform the requested
    /// action now - but it could later. It's usually used to guard a render operation
    /// when a reconfiguration of its internal state is being performed.
    ///
    /// > File: AudioToolkit/AUComponent.h
    ///
    /// > Constant: `kAudioUnitErr_CannotDoInCurrentContext`
    case cannotDoInCurrentContext
    
    /// Invalid property value.
    ///
    /// The property is valid, but the value of the property being provided is not.
    ///
    /// > File: AudioToolkit/AUComponent.h
    ///
    /// > Constant: `kAudioUnitErr_InvalidPropertyValue`
    case invalidPropertyValue
    
    /// Property not in use.
    ///
    /// Returned when a property is valid, but it hasn't been set to a valid value at
    /// this time.
    ///
    /// > File: AudioToolkit/AUComponent.h
    ///
    /// > Constant: `kAudioUnitErr_PropertyNotInUse`
    case propertyNotInUse
    
    /// (Already) Initialized.
    ///
    /// Indicates the operation cannot be performed because the audio unit is initialized.
    ///
    /// > File: AudioToolkit/AUComponent.h
    ///
    /// > Constant: `kAudioUnitErr_Initialized`
    case initialized
    
    /// Invalid offline render.
    ///
    /// Used to indicate that the offline render operation is invalid. For instance,
    /// when the audio unit needs to be pre-flighted, but it hasn't been.
    ///
    /// > File: AudioToolkit/AUComponent.h
    ///
    /// > Constant: `kAudioUnitErr_InvalidOfflineRender`
    case invalidOfflineRender
    
    /// Unauthorized.
    ///
    /// Returned by either Open or Initialize, this error is used to indicate that the
    /// audio unit is not authorised, that it cannot be used. A host can then present
    /// a UI to notify the user the audio unit is not able to be used in its current
    /// state.
    ///
    /// > File: AudioToolkit/AUComponent.h
    ///
    /// > Constant: `kAudioUnitErr_Unauthorized`
    case unauthorized
    
    /// MIDI output buffer full.
    ///
    /// Returned during the render call, if the audio unit produces more MIDI output,
    /// than the default allocated buffer. The audio unit can provide a size hint, in
    /// case it needs a larger buffer. See the documentation for AUAudioUnit's
    /// `MIDIOutputBufferSizeHint` property.
    ///
    /// > File: AudioToolkit/AUComponent.h
    ///
    /// > Constant: `kAudioUnitErr_MIDIOutputBufferFull`
    case midiOutputBufferFull
    
    /// Instance timed out.
    ///
    /// > File: AudioToolkit/AUComponent.h
    ///
    /// > Constant: `kAudioComponentErr_InstanceTimedOut`
    case instanceTimedOut
    
    /// Instance invalidated.
    ///
    /// The component instance's implementation is not available, most likely because the process
    /// that published it is no longer running.
    ///
    /// > File: AudioToolkit/AUComponent.h
    ///
    /// > Constant: `kAudioComponentErr_InstanceInvalidated`
    case instanceInvalidated
    
    /// Render timeout.
    ///
    /// The audio unit did not satisfy the render request in time.
    ///
    /// > File: AudioToolkit/AUComponent.h
    ///
    /// > Constant: `kAudioUnitErr_RenderTimeout`
    case renderTimeout
    
    /// The specified identifier did not match any Audio Unit Extensions.
    ///
    /// > File: AudioToolkit/AUComponent.h
    ///
    /// > Constant: `kAudioUnitErr_ExtensionNotFound`
    case extensionNotFound
    
    /// Invalid parameter value.
    ///
    /// The parameter value is not supported, e.g. the value specified is NaN or infinite.
    ///
    /// > File: AudioToolkit/AUComponent.h
    ///
    /// > Constant: `kAudioUnitErr_InvalidParameterValue`
    case invalidParameterValue
    
    /// Invalid file path.
    ///
    /// The file path that was passed is not supported. It is either too long or contains
    /// invalid characters.
    ///
    /// > File: AudioToolkit/AUComponent.h
    ///
    /// > Constant: `kAudioUnitErr_InvalidFilePath`
    case invalidFilePath
    
    /// Missing key.
    ///
    /// A required key is missing from a dictionary object.
    ///
    /// > File: AudioToolkit/AUComponent.h
    ///
    /// > Constant: `kAudioUnitErr_MissingKey`
    case missingKey
    
    /// Component manager not supported.
    ///
    /// The operation can not be performed for a component instance instantiated using the
    /// deprecated Component Manager. A host application should use the API functions
    /// `AudioComponentInstantiate` or `AudioComponentInstanceNew` when rebuilding
    /// against the macOS 11 or later SDK.
    ///
    /// > File: AudioToolkit/AUComponent.h
    ///
    /// > Constant: `kAudioUnitErr_ComponentManagerNotSupported`
    case componentManagerNotSupported
    
    /// Multiple voice processors.
    ///
    /// On some platforms, this error is returned when a client attempts to initialize
    /// a voice processor instance while another is initialized.
    ///
    /// > File: AudioToolkit/AUComponent.h
    ///
    /// > Constant: `kAudioUnitErr_MultipleVoiceProcessors`
    case multipleVoiceProcessors
    
    // MARK: AudioToolkit/AUComponent.h - Inter-App Audio
    
    // AudioComponent errors for inter-app audio
    //
    // kAudioComponentErr_DuplicateDescription    = -66752
    // kAudioComponentErr_UnsupportedType         = -66751
    // kAudioComponentErr_TooManyInstances        = -66750
    // kAudioComponentErr_NotPermitted            = -66748
    // kAudioComponentErr_InitializationTimedOut  = -66747
    // kAudioComponentErr_InvalidFormat           = -66746
    
    /// Duplicate description.
    ///
    /// A non-unique component description was provided to `AudioOutputUnitPublish`.
    ///
    /// > File: AudioToolkit/AUComponent.h (Inter-App Audio)
    ///
    /// > Constant: `kAudioComponentErr_DuplicateDescription`
    case duplicateDescription
    
    /// Unsupported type.
    ///
    /// An unsupported component type was provided to `AudioOutputUnitPublish`.
    ///
    /// > File: AudioToolkit/AUComponent.h (Inter-App Audio)
    ///
    /// > Constant: `kAudioComponentErr_UnsupportedType`
    case unsupportedType
    
    /// Too many instances.
    ///
    /// Components published via `AudioOutputUnitPublish` may only have one instance.
    ///
    /// > File: AudioToolkit/AUComponent.h (Inter-App Audio)
    ///
    /// > Constant: `kAudioComponentErr_TooManyInstances`
    case tooManyInstances
    
    /// Not permitted.
    ///
    /// App needs `inter-app-audio` entitlement or host app needs `audio` in its `UIBackgroundModes`.
    /// Or app is trying to register a component not declared in its `Info.plist`.
    ///
    /// > File: AudioToolkit/AUComponent.h (Inter-App Audio)
    ///
    /// > Constant: `kAudioComponentErr_NotPermitted`
    case notPermitted
    
    /// Initialization timed out.
    ///
    /// Host did not render in a timely manner; must uninitialize and reinitialize.
    ///
    /// > File: AudioToolkit/AUComponent.h (Inter-App Audio)
    ///
    /// > Constant: `kAudioComponentErr_InitializationTimedOut`
    case initializationTimedOut
    
    /// Invalid format.
    ///
    /// Inter-app AU element formats must have sample rates matching the hardware.
    ///
    /// > File: AudioToolkit/AUComponent.h (Inter-App Audio)
    ///
    /// > Constant: `kAudioComponentErr_InvalidFormat`
    case invalidFormat
    
    // MARK: AudioToolkit/AUComponent.h - Deprecated
    
    // Audio unit errors - deprecated
    //
    // These are the various errors that can be returned by `AudioUnit*` API calls
    //
    // kAudioUnitErr_IllegalInstrument      = -10873
    // kAudioUnitErr_InstrumentTypeNotFound = -10872
    
    /// Illegal instrument.
    ///
    /// Apple's DLS synth returns this error if information about a particular
    /// instrument patch is requested, but is not valid.
    ///
    /// > File: AudioToolkit/AUComponent.h (Deprecated)
    ///
    /// > Constant: `kAudioUnitErr_IllegalInstrument`
    case illegalInstrument
    
    /// Instrument type not found.
    ///
    /// Apple's DLS synth returns this error if information about a particular
    /// instrument patch is requested, but is not valid.
    ///
    /// > File: AudioToolkit/AUComponent.h (Deprecated)
    ///
    /// > Constant: `kAudioUnitErr_InstrumentTypeNotFound`
    case instrumentTypeNotFound
    
    // MARK: AudioToolkit/AudioCodec.h
    
    // Possible errors returned by audio codec components
    //
    // kAudioCodecNoError                   = 0       // duplicate of a kAudioHardware constant
    // kAudioCodecUnspecifiedError          = 'what'  // duplicate of a kAudioHardware constant
    // kAudioCodecUnknownPropertyError      = 'who?'  // duplicate of a kAudioHardware constant
    // kAudioCodecBadPropertySizeError      = '!siz'  // duplicate of a kAudioHardware constant
    // kAudioCodecIllegalOperationError     = 'nope'  // duplicate of a kAudioHardware constant
    // kAudioCodecUnsupportedFormatError    = '!dat'  // duplicate of a kAudioHardware constant
    // kAudioCodecStateError                = '!stt'
    // kAudioCodecNotEnoughBufferSpaceError = '!buf'
    // kAudioCodecBadDataError              = 'bada'
    
    /// The codec is in an invalid state.
    ///
    /// > File: AudioToolkit/AudioCodec.h
    ///
    /// > Constant: `kAudioCodecStateError`
    case stateError
    
    /// Not enough buffer space available.
    ///
    /// > File: AudioToolkit/AudioCodec.h
    ///
    /// > Constant: `kAudioCodecNotEnoughBufferSpaceError`
    case notEnoughBufferSpace
    
    /// Bad codec data.
    ///
    /// > File: AudioToolkit/AudioCodec.h
    ///
    /// > Constant: `kAudioCodecBadDataError`
    case badData
    
    // MARK: AudioToolkit/AudioConverter.h
    
    // TODO: Needs Implementing
    // kAudioConverterErr_FormatNotSupported              = 'fmt?',
    // kAudioConverterErr_OperationNotSupported           = 'op??'
    // kAudioConverterErr_PropertyNotSupported            = 'prop',
    // kAudioConverterErr_InvalidInputSize                = 'insz',
    // kAudioConverterErr_InvalidOutputSize               = 'otsz',
    // kAudioConverterErr_UnspecifiedError                = 'what',
    // kAudioConverterErr_BadPropertySizeError            = '!siz',
    // kAudioConverterErr_RequiresPacketDescriptionsError = '!pkd',
    // kAudioConverterErr_InputSampleRateOutOfRange       = '!isr',
    // kAudioConverterErr_OutputSampleRateOutOfRange      = '!osr'
    // iOS:
    // kAudioConverterErr_HardwareInUse                   = 'hwiu'
    // kAudioConverterErr_NoHardwarePermission            = 'perm'
    
    // MARK: AudioToolkit/AudioFile.h
    
    // TODO: Needs Implementing
    // kAudioFileUnspecifiedError               = 'wht?'
    // kAudioFileUnsupportedFileTypeError       = 'typ?'
    // kAudioFileUnsupportedDataFormatError     = 'fmt?'
    // kAudioFileUnsupportedPropertyError       = 'pty?'
    // kAudioFileBadPropertySizeError           = '!siz'
    // kAudioFilePermissionsError               = 'prm?'
    // kAudioFileNotOptimizedError              = 'optm'
    // file format specific error codes
    // kAudioFileInvalidChunkError              = 'chk?'
    // kAudioFileDoesNotAllow64BitDataSizeError = 'off?'
    // kAudioFileInvalidPacketOffsetError       = 'pck?'
    // kAudioFileInvalidPacketDependencyError   = 'dep?'
    // kAudioFileInvalidFileError               = 'dta?'
    // kAudioFileOperationNotSupportedError     = 'op??'
    // general file error codes
    // kAudioFileNotOpenError                   = -38
    // kAudioFileEndOfFileError                 = -39
    // kAudioFilePositionError                  = -40
    // kAudioFileFileNotFoundError              = -43
    
    // MARK: AudioToolkit/AudioFileStream.h
    
    // TODO: Needs Implementing
    // kAudioFileStreamError_UnsupportedFileType      = 'typ?'
    // kAudioFileStreamError_UnsupportedDataFormat    = 'fmt?'
    // kAudioFileStreamError_UnsupportedProperty      = 'pty?'
    // kAudioFileStreamError_BadPropertySize          = '!siz'
    // kAudioFileStreamError_NotOptimized             = 'optm'
    // kAudioFileStreamError_InvalidPacketOffset      = 'pck?'
    // kAudioFileStreamError_InvalidFile              = 'dta?'
    // kAudioFileStreamError_ValueUnknown             = 'unk?'
    // kAudioFileStreamError_DataUnavailable          = 'more'
    // kAudioFileStreamError_IllegalOperation         = 'nope'
    // kAudioFileStreamError_UnspecifiedError         = 'wht?'
    // kAudioFileStreamError_DiscontinuityCantRecover = 'dsc!'
    
    // MARK: AudioToolkit/AudioFormat.h
    
    // TODO: Needs Implementing
    // kAudioFormatUnspecifiedError           = 'what'
    // kAudioFormatUnsupportedPropertyError   = 'prop'
    // kAudioFormatBadPropertySizeError       = '!siz'
    // kAudioFormatBadSpecifierSizeError      = '!spc'
    // kAudioFormatUnsupportedDataFormatError = 'fmt?'
    // kAudioFormatUnknownFormatError         = '!fmt'
    
    // MARK: AudioToolkit/AudioQueue.h
    
    // TODO: Needs Implementing
    // kAudioQueueErr_InvalidBuffer        = -66687
    // kAudioQueueErr_BufferEmpty          = -66686
    // kAudioQueueErr_DisposalPending      = -66685
    // kAudioQueueErr_InvalidProperty      = -66684
    // kAudioQueueErr_InvalidPropertySize  = -66683
    // kAudioQueueErr_InvalidParameter     = -66682
    // kAudioQueueErr_CannotStart          = -66681
    // kAudioQueueErr_InvalidDevice        = -66680
    // kAudioQueueErr_BufferInQueue        = -66679
    // kAudioQueueErr_InvalidRunState      = -66678
    // kAudioQueueErr_InvalidQueueType     = -66677
    // kAudioQueueErr_Permissions          = -66676
    // kAudioQueueErr_InvalidPropertyValue = -66675
    // kAudioQueueErr_PrimeTimedOut        = -66674
    // kAudioQueueErr_CodecNotFound        = -66673
    // kAudioQueueErr_InvalidCodecAccess   = -66672
    // kAudioQueueErr_QueueInvalidated     = -66671
    // kAudioQueueErr_TooManyTaps          = -66670
    // kAudioQueueErr_InvalidTapContext    = -66669
    // kAudioQueueErr_RecordUnderrun       = -66668
    // kAudioQueueErr_InvalidTapType       = -66667
    // kAudioQueueErr_BufferEnqueuedTwice  = -66666
    // kAudioQueueErr_CannotStartYet       = -66665
    // kAudioQueueErr_EnqueueDuringReset   = -66632
    // kAudioQueueErr_InvalidOfflineMode   = -66626
    
    // MARK: AudioToolkit/AudioServices.h
    
    // TODO: Needs Implementing
    // kAudioServicesNoError                                 = 0
    // kAudioServicesUnsupportedPropertyError                = 'pty?'
    // kAudioServicesBadPropertySizeError                    = '!siz'
    // kAudioServicesBadSpecifierSizeError                   = '!spc'
    // kAudioServicesSystemSoundUnspecifiedError             = -1500
    // kAudioServicesSystemSoundClientTimedOutError          = -1501
    // kAudioServicesSystemSoundExceededMaximumDurationError = -1502
    
    // MARK: AudioToolkit/AudioUnitProperties.h

    // Apple Voice Processing AudioUnit Error IDs
    //
    // These are the various error IDs returned by Voice Processing audio unit.
    //
    // kAUVoiceIOErr_UnexpectedNumberOfInputChannels = -66784
    
    // /// An unexpected number of input channels was encountered.
    // ///
    // /// This error indicates that an unexpected number of input channels was encountered
    // /// during initialization of voice processing audio unit.
    // ///
    // /// > File: AudioToolkit/AudioUnitProperties.h
    // ///
    // /// > Constant: `kAUVoiceIOErr_UnexpectedNumberOfInputChannels`
    // case unexpectedNumberOfInputChannels
    
    // MARK: AudioToolkit/AUGraph.h
    
    // TODO: Needs Implementing
    // kAUGraphErr_NodeNotFound             = -10860
    // kAUGraphErr_InvalidConnection        = -10861
    // kAUGraphErr_OutputNodeErr            = -10862
    // kAUGraphErr_CannotDoInCurrentContext = -10863
    // kAUGraphErr_InvalidAudioUnit         = -10864
    
    // MARK: AudioToolkit/CoreAudioClock.h
    
    // TODO: Needs Implementing
    // kCAClock_UnknownPropertyError       = -66816
    // kCAClock_InvalidPropertySizeError   = -66815
    // kCAClock_InvalidTimeFormatError     = -66814
    // kCAClock_InvalidSyncModeError       = -66813
    // kCAClock_InvalidSyncSourceError     = -66812
    // kCAClock_InvalidTimebaseError       = -66811
    // kCAClock_InvalidTimebaseSourceError = -66810
    // kCAClock_InvalidSMPTEFormatError    = -66809
    // kCAClock_InvalidSMPTEOffsetError    = -66808
    // kCAClock_InvalidUnitError           = -66807
    // kCAClock_InvalidPlayRateError       = -66806
    // kCAClock_CannotSetTimeError         = -66805
    
    // MARK: AudioToolkit/ExtendedAudioFile.h
    
    // TODO: Needs Implementing
    // kExtAudioFileError_InvalidProperty          = -66561
    // kExtAudioFileError_InvalidPropertySize      = -66562
    // kExtAudioFileError_NonPCMClientFormat       = -66563
    // kExtAudioFileError_InvalidChannelMap        = -66564
    // kExtAudioFileError_InvalidOperationOrder    = -66565
    // kExtAudioFileError_InvalidDataFormat        = -66566
    // kExtAudioFileError_MaxPacketSizeUnknown     = -66567
    // kExtAudioFileError_InvalidSeek              = -66568
    // kExtAudioFileError_AsyncWriteTooLarge       = -66569
    // kExtAudioFileError_AsyncWriteBufferOverflow = -66570
    // iOS:
    // kExtAudioFileError_CodecUnavailableInputConsumed    = -66559
    // kExtAudioFileError_CodecUnavailableInputNotConsumed = -66560
    
    // MARK: AudioToolkit/MusicPlayer.h
    
    // TODO: Needs Implementing
    // kAudioToolboxErr_InvalidSequenceType      = -10846
    // kAudioToolboxErr_TrackIndexError          = -10859
    // kAudioToolboxErr_TrackNotFound            = -10858
    // kAudioToolboxErr_EndOfTrack               = -10857
    // kAudioToolboxErr_StartOfTrack             = -10856
    // kAudioToolboxErr_IllegalTrackDestination  = -10855
    // kAudioToolboxErr_NoSequence               = -10854
    // kAudioToolboxErr_InvalidEventType         = -10853
    // kAudioToolboxErr_InvalidPlayerState       = -10852
    // kAudioToolboxErr_CannotDoInCurrentContext = -10863
    // kAudioToolboxError_NoTrackDestination     = -66720
}

extension AudioOSStatus: Equatable { }

extension AudioOSStatus: Hashable { }

extension AudioOSStatus: CaseIterable { }

extension AudioOSStatus: Sendable { }

extension AudioOSStatus: RawRepresentable {
    nonisolated
    public init?(rawValue: OSStatus) { // a.k.a. Int32
        guard let match = Self.allCases
            .first(where: { $0.rawValue == rawValue })
        else {
            return nil
        }
        self = match
    }
    
    nonisolated
    public var rawValue: OSStatus { // a.k.a. Int32
        switch self {
        // MARK: CoreAudio/AudioHardwareBase.h
        case .noError: kAudioHardwareNoError // 0
        case .notRunning: kAudioHardwareNotRunningError // "stop"
        case .unspecifiedError: kAudioHardwareUnspecifiedError // "what"
        case .unknownProperty: kAudioHardwareUnknownPropertyError // "who?"
        case .badPropertySize: kAudioHardwareBadPropertySizeError // "!siz"
        case .illegalOperation: kAudioHardwareIllegalOperationError // "nope"
        case .badObject: kAudioHardwareBadObjectError // "!obj"
        case .badDevice: kAudioHardwareBadDeviceError // "!dev"
        case .badStream: kAudioHardwareBadStreamError // "!str"
        case .unsupportedOperation: kAudioHardwareUnsupportedOperationError // "unop"
        case .notReady: kAudioHardwareNotReadyError // "nrdy"
        case .unsupportedFormat: kAudioDeviceUnsupportedFormatError // "!dat"
        case .permissionsError: kAudioDevicePermissionsError // "!hog"
        // MARK: CoreAudioTypes/CoreAudioBaseTypes.h
        case .unimplemented: kAudio_UnimplementedError // -4
        case .fileNotFound: kAudio_FileNotFoundError // -43
        case .filePermission: kAudio_FilePermissionError // -54
        case .tooManyFilesOpen: kAudio_TooManyFilesOpenError // -42
        case .badFilePath: kAudio_BadFilePathError // '!pth
        case .paramError: kAudio_ParamError // -50
        case .memFull: kAudio_MemFullError // -108
        // MARK: AudioToolkit/AUComponent.h
        case .invalidProperty: kAudioUnitErr_InvalidProperty // -10879
        case .invalidParameter: kAudioUnitErr_InvalidParameter // -10878
        case .invalidElement: kAudioUnitErr_InvalidElement // -10877
        case .noConnection: kAudioUnitErr_NoConnection // -10876
        case .failedInitialization: kAudioUnitErr_FailedInitialization // -10875
        case .tooManyFramesToProcess: kAudioUnitErr_TooManyFramesToProcess // -10874
        case .invalidFile: kAudioUnitErr_InvalidFile // -10871
        case .unknownFileType: kAudioUnitErr_UnknownFileType // -10870
        case .fileNotSpecified: kAudioUnitErr_FileNotSpecified // -10869
        case .formatNotSupported: kAudioUnitErr_FormatNotSupported // -10868
        case .uninitialized: kAudioUnitErr_Uninitialized // -10867
        case .invalidScope: kAudioUnitErr_InvalidScope // -10866
        case .propertyNotWritable: kAudioUnitErr_PropertyNotWritable // -10865
        case .cannotDoInCurrentContext: kAudioUnitErr_CannotDoInCurrentContext // -10863
        case .invalidPropertyValue: kAudioUnitErr_InvalidPropertyValue // -10851
        case .propertyNotInUse: kAudioUnitErr_PropertyNotInUse // -10850
        case .initialized: kAudioUnitErr_Initialized // -10849
        case .invalidOfflineRender: kAudioUnitErr_InvalidOfflineRender // -10848
        case .unauthorized: kAudioUnitErr_Unauthorized // -10847
        case .midiOutputBufferFull: kAudioUnitErr_MIDIOutputBufferFull // -66753
        case .instanceTimedOut: kAudioComponentErr_InstanceTimedOut // -66754
        case .instanceInvalidated: kAudioComponentErr_InstanceInvalidated // -66749
        case .renderTimeout: kAudioUnitErr_RenderTimeout // -66745
        case .extensionNotFound: kAudioUnitErr_ExtensionNotFound // -66744
        case .invalidParameterValue: kAudioUnitErr_InvalidParameterValue // -66743
        case .invalidFilePath: kAudioUnitErr_InvalidFilePath // -66742
        case .missingKey: kAudioUnitErr_MissingKey // -66741
        case .componentManagerNotSupported: kAudioUnitErr_ComponentManagerNotSupported // -66740
        case .multipleVoiceProcessors: kAudioUnitErr_MultipleVoiceProcessors // -66635
        // MARK: AudioToolkit/AUComponent.h - Inter-App Audio
        case .duplicateDescription: kAudioComponentErr_DuplicateDescription // -66752,
        case .unsupportedType: kAudioComponentErr_UnsupportedType // -66751,
        case .tooManyInstances: kAudioComponentErr_TooManyInstances // -66750,
        case .notPermitted: kAudioComponentErr_NotPermitted // -66748,
        case .initializationTimedOut: kAudioComponentErr_InitializationTimedOut // -66747,
        case .invalidFormat: kAudioComponentErr_InvalidFormat // -66746
        // MARK: AudioToolkit/AUComponent.h - Deprecated
        case .illegalInstrument: kAudioUnitErr_IllegalInstrument // -10873
        case .instrumentTypeNotFound: kAudioUnitErr_InstrumentTypeNotFound // -10872
        // MARK: AudioToolkit/AudioCodec.h
        case .stateError: kAudioCodecStateError // "!stt"
        case .notEnoughBufferSpace: kAudioCodecNotEnoughBufferSpaceError // "!buf"
        case .badData: kAudioCodecBadDataError // "bada"
        }
    }
}
