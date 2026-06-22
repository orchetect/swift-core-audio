//
//  AudioFormat.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import Foundation

/// Audio format IDs.
///
/// The `AudioFormatID`s used to identify individual formats of audio data.
///
/// CoreAudio `kAudioFormat*` constants.
public enum AudioFormat {
    // MARK: CoreAudioTypes/CoreAudioBaseTypes.h

    /// Linear PCM
    ///
    /// The Linear PCM codec is a non-compressed audio data format with one frame per packet.
    ///
    /// Uses the standard flags.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudioFormatLinearPCM`
    case linearPCM

    /// AC-3
    ///
    /// Has no flags.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudioFormatAC3`
    case ac3

    /// AC-3 (IEC 60958)
    ///
    /// AC-3 codec, which provides data packaged for transport over an IEC 60958-compliant
    /// digital audio interface, and uses standard flags.
    ///
    /// Uses the standard flags.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudioFormat60958AC3`
    case ac3_IEC60958

    /// IMA 4:1 ADPCM (Apple's Implementation)
    ///
    /// Has no flags.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudioFormatAppleIMA4`
    case appleIMA4

    /// MPEG-4 Low Complexity AAC
    ///
    /// Has no flags.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudioFormatMPEG4AAC`
    case mpeg4AAC

    /// MPEG-4 CELP Audio Object
    ///
    /// Has no flags.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudioFormatMPEG4CELP`
    case mpeg4CELP

    /// MPEG-4 HVXC Audio Object
    ///
    /// Has no flags.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudioFormatMPEG4HVXC`
    case mpeg4HVXC

    /// MPEG-4 TwinVQ
    ///
    /// Has no flags.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudioFormatMPEG4TwinVQ`
    case mpeg4TwinVQ

    /// MACE 3:1
    ///
    /// Has no flags.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudioFormatMACE3`
    case mace3

    /// MACE 6:1
    ///
    /// Has no flags.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudioFormatMACE6`
    case mace6

    /// µLaw 2:1
    ///
    /// Has no flags.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudioFormatULaw`
    case uLaw

    /// aLaw 2:1
    ///
    /// Has no flags.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudioFormatALaw`
    case aLaw

    /// QDesign Music
    ///
    /// Has no flags.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudioFormatQDesign`
    case qDesign

    /// QDesign2 Music
    ///
    /// Has no flags.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudioFormatQDesign2`
    case qDesign2

    /// QUALCOMM PureVoice
    ///
    /// Has no flags.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudioFormatQUALCOMM`
    case qualcomm

    /// MPEG-1/2, Layer 1
    ///
    /// Has no flags.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudioFormatMPEGLayer1`
    case mpegLayer1

    /// MPEG-1/2, Layer 2
    ///
    /// Has no flags.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudioFormatMPEGLayer2`
    case mpegLayer2

    /// MPEG-1/2, Layer 3
    ///
    /// Has no flags.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudioFormatMPEGLayer3`
    case mpegLayer3

    /// Timecode
    ///
    /// A stream of audio timestamp structures (`IOAudioTimeStamp`s).
    ///
    /// Uses the `IOAudioTimeStamp` flags.
    ///
    /// See `IOKit/audio/IOAudioTypes.h`
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudioFormatTimeCode`
    case timeCode

    /// MIDI Stream
    ///
    /// This codec contains a stream of `MIDIPacketList` structures where the time stamps are
    /// sample offsets in the stream. The `mSampleRate` field describes how time passes in this stream.
    ///
    /// An audio unit that receives or generates this stream can use this sample rate, the number of
    /// frames it’s rendering, and the sample offsets within the `MIDIPacketList` to define the time
    /// for any MIDI event within this list.
    ///
    /// Has no flags.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudioFormatMIDIStream`
    case midiStream

    /// Parameter Value Stream
    ///
    /// A "side-chain" of `Float32` data that can be fed or generated by an `AudioUnit`
    /// and is used to send a high density of parameter value control information.
    ///
    /// An audio unit typically runs a parameter value stream at either:
    ///
    /// - The sample rate of the audio unit’s audio data.
    /// - An integer quotient such as a half or a third of the sample rate of the audio.
    ///
    /// The `mSampleRate` field in the `AudioStreamBasicDescription` structure describes this
    /// relationship.
    ///
    /// Has no flags.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudioFormatParameterValueStream`
    case parameterValueStream

    /// Apple Lossless
    ///
    /// The flags indicate the bit depth of the source material.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudioFormatAppleLossless`
    case appleLossless

    /// MPEG-4 High Efficiency AAC
    ///
    /// Has no flags.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudioFormatMPEG4AAC_HE`
    case mpeg4AAC_HE

    /// MPEG-4 AAC Low Delay
    ///
    /// Has no flags.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudioFormatMPEG4AAC_LD`
    case mpeg4AAC_LD

    /// MPEG-4 AAC Enhanced Low Delay
    ///
    /// This is the formatID of the base layer without the SBR extension.
    ///
    /// See also `kAudioFormatMPEG4AAC_ELD_SBR`.
    ///
    /// Has no flags.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudioFormatMPEG4AAC_ELD`
    case mpeg4AAC_ELD

    /// MPEG-4 AAC Enhanced Low Delay with SBR
    ///
    /// MPEG-4 Enhanced Low Delay AAC codec with a spectral band replication (SBR) extension layer.
    ///
    /// Has no flags.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudioFormatMPEG4AAC_ELD_SBR`
    case mpeg4AAC_ELD_SBR

    /// MPEG-4 Enhanced Low Delay AAC Version 2
    ///
    /// Has no flags.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudioFormatMPEG4AAC_ELD_V2`
    case mpeg4AAC_ELD_V2

    /// MPEG-4 High Efficiency AAC Version 2
    ///
    /// Has no flags.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudioFormatMPEG4AAC_HE_V2`
    case mpeg4AAC_HE_V2

    /// MPEG-4 Spatial Audio
    ///
    /// Has no flags.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudioFormatMPEG4AAC_Spatial`
    case mpeg4AAC_Spatial

    /// MPEG-D Unified Speech and Audio Coding
    ///
    /// Has no flags.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudioFormatMPEGD_USAC`
    case mpegD_USAC

    /// AMR Narrow Band Speech
    ///
    /// Adaptive Multi-Rate (AMR) narrow band speech codec.
    ///
    /// Has no flags.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudioFormatAMR`
    case amr

    /// AMR Wide Band Speech
    ///
    /// Adaptive Multi-Rate (AMR) wide band speech codec.
    ///
    /// Has no flags.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudioFormatAMR_WB`
    case amr_WB

    /// Audible
    ///
    /// The format used for Audible audio books.
    ///
    /// Has no flags.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudioFormatAudible`
    case audible

    /// iLBC Narrow Band Speech
    ///
    /// Low Bitrate Codec (iLBC) narrow band speech codec.
    ///
    /// Has no flags.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudioFormatiLBC`
    case iLBC

    /// DVI/Intel IMA ADPCM - ACM code 17
    ///
    /// Has no flags.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudioFormatDVIIntelIMA`
    case dviIntelIMA

    /// Microsoft GSM 6.10 - ACM code 49
    ///
    /// Has no flags.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudioFormatMicrosoftGSM`
    case microsoftGSM

    /// AES3-2003
    ///
    /// This format is defined by AES3-2003.
    ///
    /// The MXF and MPEG-2 containers and SDTI transport streams with SMPTE specs
    /// 302M-2002 and 331M-2000 adopt this codec.
    ///
    /// Has no flags.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudioFormatAES3`
    case aes3

    /// Enhanced AC-3
    ///
    /// Has no flags.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudioFormatEnhancedAC3`
    case enhancedAC3

    /// Free Lossless Audio Codec (FLAC)
    ///
    /// The flags indicate the bit depth of the source material.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudioFormatFLAC`
    case flac

    /// Opus
    ///
    /// Has no flags.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudioFormatOpus`
    case opus

    /// Apple Positional Audio Codec
    ///
    /// Has no flags.
    ///
    /// > File: CoreAudioTypes/CoreAudioBaseTypes.h
    ///
    /// > Constant: `kAudioFormatAPAC`
    case apac
}

extension AudioFormat: Equatable { }

extension AudioFormat: Hashable { }

extension AudioFormat: CaseIterable { }

extension AudioFormat: Sendable { }

// MARK: - Inits

extension AudioFormat {
    /// Same as ``init(rawValue:)`` but throws an error instead of returning `nil` when a match is not found.
    nonisolated
    public init(tryingRawValue rawValue: AudioFormatID) throws(SwiftCoreAudioError) { // a.k.a. FourCharChode, a.k.a. UInt32
        guard let match = Self(rawValue: rawValue) else {
            throw .notYetImplemented(message: "Unhandled/unrecognized audio format ID type value: \(rawValue)")
        }
        self = match
    }
}

// MARK: - RawRepresentable

extension AudioFormat: RawRepresentable {
    nonisolated
    public init?(rawValue: AudioFormatID) { // a.k.a. FourCharChode, a.k.a. UInt32
        guard let match = Self.allCases
            .first(where: { $0.rawValue == rawValue })
        else {
            return nil
        }
        self = match
    }

    nonisolated
    public var rawValue: AudioFormatID { // a.k.a. FourCharChode, a.k.a. UInt32
        switch self {
        case .linearPCM: kAudioFormatLinearPCM // "lpcm"
        case .ac3: kAudioFormatAC3 // "ac-3"
        case .ac3_IEC60958: kAudioFormat60958AC3 // "cac3"
        case .appleIMA4: kAudioFormatAppleIMA4 // "ima4"
        case .mpeg4AAC: kAudioFormatMPEG4AAC // "aac "
        case .mpeg4CELP: kAudioFormatMPEG4CELP // "celp"
        case .mpeg4HVXC: kAudioFormatMPEG4HVXC // "hvxc"
        case .mpeg4TwinVQ: kAudioFormatMPEG4TwinVQ // "twvq"
        case .mace3: kAudioFormatMACE3 // "MAC3"
        case .mace6: kAudioFormatMACE6 // "MAC6"
        case .uLaw: kAudioFormatULaw // "ulaw"
        case .aLaw: kAudioFormatALaw // "alaw"
        case .qDesign: kAudioFormatQDesign // "QDMC"
        case .qDesign2: kAudioFormatQDesign2 // "QDM2"
        case .qualcomm: kAudioFormatQUALCOMM // "Qclp"
        case .mpegLayer1: kAudioFormatMPEGLayer1 // ".mp1"
        case .mpegLayer2: kAudioFormatMPEGLayer2 // ".mp2"
        case .mpegLayer3: kAudioFormatMPEGLayer3 // ".mp3"
        case .timeCode: kAudioFormatTimeCode // "time"
        case .midiStream: kAudioFormatMIDIStream // "midi"
        case .parameterValueStream: kAudioFormatParameterValueStream // "apvs"
        case .appleLossless: kAudioFormatAppleLossless // "alac"
        case .mpeg4AAC_HE: kAudioFormatMPEG4AAC_HE // "aach"
        case .mpeg4AAC_LD: kAudioFormatMPEG4AAC_LD // "aacl"
        case .mpeg4AAC_ELD: kAudioFormatMPEG4AAC_ELD // "aace"
        case .mpeg4AAC_ELD_SBR: kAudioFormatMPEG4AAC_ELD_SBR // "aacf"
        case .mpeg4AAC_ELD_V2: kAudioFormatMPEG4AAC_ELD_V2 // "aacg"
        case .mpeg4AAC_HE_V2: kAudioFormatMPEG4AAC_HE_V2 // "aacp"
        case .mpeg4AAC_Spatial: kAudioFormatMPEG4AAC_Spatial // "aacs"
        case .mpegD_USAC: kAudioFormatMPEGD_USAC // "usac"
        case .amr: kAudioFormatAMR // "samr"
        case .amr_WB: kAudioFormatAMR_WB // "sawb"
        case .audible: kAudioFormatAudible // "AUDB"
        case .iLBC: kAudioFormatiLBC // "ilbc"
        case .dviIntelIMA: kAudioFormatDVIIntelIMA // 0x6D730011
        case .microsoftGSM: kAudioFormatMicrosoftGSM // 0x6D730031
        case .aes3: kAudioFormatAES3 // "aes3"
        case .enhancedAC3: kAudioFormatEnhancedAC3 // "ec-3"
        case .flac: kAudioFormatFLAC // "flac"
        case .opus: kAudioFormatOpus // "opus"
        case .apac: kAudioFormatAPAC // "apac"
        }
    }
}

extension AudioFormat: CustomStringConvertible {
    nonisolated
    public var description: String {
        switch self {
        case .linearPCM: "Linear PCM"
        case .ac3: "AC-3"
        case .ac3_IEC60958: "AC-3 (IEC 60958)"
        case .appleIMA4: "IMA 4:1 ADPCM (Apple's Implementation)"
        case .mpeg4AAC: "MPEG-4 Low Complexity AAC"
        case .mpeg4CELP: "MPEG-4 CELP Audio Object"
        case .mpeg4HVXC: "MPEG-4 HVXC Audio Object"
        case .mpeg4TwinVQ: "MPEG-4 TwinVQ"
        case .mace3: "MACE 3:1"
        case .mace6: "MACE 6:1"
        case .uLaw: "µLaw 2:1"
        case .aLaw: "aLaw 2:1"
        case .qDesign: "QDesign Music"
        case .qDesign2: "QDesign2 Music"
        case .qualcomm: "QUALCOMM PureVoice"
        case .mpegLayer1: "MPEG-1/2, Layer 1"
        case .mpegLayer2: "MPEG-1/2, Layer 2"
        case .mpegLayer3: "MPEG-1/2, Layer 3"
        case .timeCode: "Timecode"
        case .midiStream: "MIDI Stream"
        case .parameterValueStream: "Parameter Value Stream"
        case .appleLossless: "Apple Lossless"
        case .mpeg4AAC_HE: "MPEG-4 High Efficiency AAC"
        case .mpeg4AAC_LD: "MPEG-4 AAC Low Delay"
        case .mpeg4AAC_ELD: "MPEG-4 AAC Enhanced Low Delay"
        case .mpeg4AAC_ELD_SBR: "MPEG-4 AAC Enhanced Low Delay with SBR"
        case .mpeg4AAC_ELD_V2: "MPEG-4 Enhanced Low Delay AAC Version 2"
        case .mpeg4AAC_HE_V2: "MPEG-4 High Efficiency AAC Version 2"
        case .mpeg4AAC_Spatial: "MPEG-4 Spatial Audio"
        case .mpegD_USAC: "MPEG-D Unified Speech and Audio Coding"
        case .amr: "AMR Narrow Band Speech"
        case .amr_WB: "AMR Wide Band Speech"
        case .audible: "Audible"
        case .iLBC: "iLBC Narrow Band Speech"
        case .dviIntelIMA: "DVI/Intel IMA ADPCM - ACM code 17"
        case .microsoftGSM: "Microsoft GSM 6.10 - ACM code 49"
        case .aes3: "AES3-2003"
        case .enhancedAC3: "Enhanced AC-3"
        case .flac: "Free Lossless Audio Codec (FLAC)"
        case .opus: "Opus"
        case .apac: "Apple Positional Audio Codec"
        }
    }
}

#endif
