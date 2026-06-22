//
//  AudioLevelControlPropertySelectorConstant.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

/// Analogous to CoreAudio `kAudioLevelControlProperty*` selector constants.
///
/// `AudioObjectPropertySelector` values provided by the `AudioLevelControl` class.
public enum AudioLevelControlPropertySelectorConstant {
    // MARK: CoreAudio/AudioHardwareBase.h

    /// Scalar Value
    ///
    /// A `Float32` that represents the value of the volume control.
    /// The range is between 0.0 and 1.0 (inclusive).
    ///
    /// Note that the set of all `Float32` values between 0.0 and 1.0 inclusive is much larger than
    /// the set of actual values that the hardware can select. This means that the `Float32` range
    /// has a many to one mapping with the underlying hardware values. As such, setting a scalar
    /// value will result in the control taking on the value nearest to what was set.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioLevelControlPropertyScalarValue`
    case scalarValue

    /// Decibel Value
    ///
    /// A Float32 that represents the value of the volume control in dB.
    ///
    /// Note that the set of all `Float32` values in the dB range for the control is much larger
    /// than the set of actual values that the hardware can select. This means that the `Float32`
    /// range has a many to one mapping with the underlying hardware values. As such, setting a
    /// dB value will result in the control taking on the value nearest to what was set.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioLevelControlPropertyDecibelValue`
    case decibelValue

    /// Decibel Range
    ///
    /// An `AudioValueRange` that contains the minimum and maximum dB values the
    /// control can have.
    ///
    /// > Constant: `kAudioLevelControlPropertyDecibelRange`
    case decibelRange

    /// Convert Scalar to Decibels
    ///
    /// A `Float32` that on input contains a scalar volume value for the and on exit
    /// contains the equivalent dB value.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioLevelControlPropertyConvertScalarToDecibels`
    case convertScalarToDecibels

    /// Convert Decibels to Scalar
    ///
    /// A `Float32` that on input contains a dB volume value for the and on exit
    /// contains the equivalent scalar value.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioLevelControlPropertyConvertDecibelsToScalar`
    case convertDecibelsToScalar

    // MARK: CoreAudio/AudioHardwareDeprecated.h

    /// Decibels to Scalar Transfer Function
    ///
    /// A `UInt32` whose value indicates the transfer function the HAL uses to convert
    /// between decibel values and scalar values.
    ///
    /// > File: CoreAudio/AudioHardwareDeprecated.h
    ///
    /// > Constant: `kAudioLevelControlPropertyDecibelsToScalarTransferFunction`
    case decibelsToScalarTransferFunction
}

extension AudioLevelControlPropertySelectorConstant: AudioPropertySelectorConstant { }

extension AudioLevelControlPropertySelectorConstant: Equatable { }

extension AudioLevelControlPropertySelectorConstant: Hashable { }

extension AudioLevelControlPropertySelectorConstant: CaseIterable { }

extension AudioLevelControlPropertySelectorConstant: Sendable { }

// MARK: - Inits

extension AudioLevelControlPropertySelectorConstant {
    /// Same as ``init(rawValue:)`` but throws an error instead of returning `nil` when a match is not found.
    nonisolated
    public init(tryingRawValue rawValue: FourCharCode) throws(SwiftCoreAudioError) { // a.k.a. UInt32
        guard let match = Self(rawValue: rawValue) else {
            throw .notYetImplemented(
                message: "Unhandled/unrecognized audio level control property selector constant value: \(rawValue)"
            )
        }
        self = match
    }
}

// MARK: - RawRepresentable

extension AudioLevelControlPropertySelectorConstant: RawRepresentable {
    nonisolated
    public init?(rawValue: FourCharCode) { // a.k.a. UInt32
        guard let match = Self.allCases
            .first(where: { $0.rawValue == rawValue })
        else {
            return nil
        }
        self = match
    }

    nonisolated
    public var rawValue: FourCharCode { // a.k.a. UInt32
        switch self {
            // MARK: CoreAudio/AudioHardwareBase.h

        case .scalarValue: kAudioLevelControlPropertyScalarValue // "lcsv"
        case .decibelValue: kAudioLevelControlPropertyDecibelValue // "lcdv"
        case .decibelRange: kAudioLevelControlPropertyDecibelRange // "lcdr"
        case .convertScalarToDecibels: kAudioLevelControlPropertyConvertScalarToDecibels // "lcsd"
        case .convertDecibelsToScalar: kAudioLevelControlPropertyConvertDecibelsToScalar // "lcds"

            // MARK: CoreAudio/AudioHardwareDeprecated.h
        case .decibelsToScalarTransferFunction: kAudioLevelControlPropertyDecibelsToScalarTransferFunction // "lctf"
        }
    }
}

extension AudioLevelControlPropertySelectorConstant: CustomStringConvertible {
    nonisolated
    public var description: String {
        switch self {
            // MARK: CoreAudio/AudioHardwareBase.h

        case .scalarValue: "Scalar Value"
        case .decibelValue: "Decibel Value"
        case .decibelRange: "Decibel Range"
        case .convertScalarToDecibels: "Convert Scalar to Decibels"
        case .convertDecibelsToScalar: "Convert Decibels to Scalar"

            // MARK: CoreAudio/AudioHardwareDeprecated.h
        case .decibelsToScalarTransferFunction: "Decibels to Scalar Transfer Function"
        }
    }
}

// MARK: - Static Constructors

extension AudioPropertySelectorConstant where Self == AudioLevelControlPropertySelectorConstant {
    /// Analogous to CoreAudio `kAudioLevelControlProperty*` selector constants.
    ///
    /// `AudioObjectPropertySelector` values provided by the `AudioLevelControl` class.
    public static func levelControl(_ selector: Self) -> Self {
        selector
    }
}

#endif
