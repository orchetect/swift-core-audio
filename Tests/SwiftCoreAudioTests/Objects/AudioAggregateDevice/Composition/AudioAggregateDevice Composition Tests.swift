//
//  AudioAggregateDevice Composition Tests.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import Foundation
import SwiftCoreAudio
import Testing

/// These are logic-only tests and do not need to be nested under ``SerializedTests``.
@Suite
struct AudioAggregateDevice_Composition_Tests {
    init() {
        CoreAudioLogging.bootstrap()
    }
    
    /// Checks the sample `Composition` for integrity.
    @Test
    func baselineCompositionCheck() throws {
        let composition = Self.sampleComposition
        try Self.checkComposition(composition: composition)
    }

    /// Checks the sample `CFDictionary` for integrity and toll-free bridging behavior.
    @Test
    func baselineCompositionCFDictionaryCheck() throws {
        let cfDict = Self.sampleCompositionCFDictionary as NSDictionary
        try Self.checkComposition(cfDictionary: cfDict)
    }

    /// Checks the sample `[String: Any]` dictionary for integrity.
    @Test
    func baselineCompositionDictionaryCheck() throws {
        let dict = Self.sampleCompositionDictionary
        try Self.checkComposition(dictionary: dict)
    }

    /// Test constructing `AudioAggregateDevice.Composition` from a `CFDictionary`.
    @Test
    func compositionInitFromCFDictionary() throws {
        // decode CFDictionary
        let cfDict = Self.sampleCompositionCFDictionary as NSDictionary
        let comp = AudioAggregateDevice.Composition(dictionary: cfDict)
        try Self.checkComposition(composition: comp)
    }

    /// Test constructing `AudioAggregateDevice.Composition` from a `[String: Any]` dictionary.
    @Test
    func compositionInitFromDictionary() throws {
        // decode CFDictionary
        let dict = Self.sampleCompositionDictionary
        let comp = AudioAggregateDevice.Composition(dictionary: dict)
        try Self.checkComposition(composition: comp)
    }

    /// Test the `CFDictionary` that is produced by `AudioAggregateDevice.Composition`.
    @Test
    func compositionCFDictionary() throws {
        let comp = Self.sampleComposition
        let cfDict = comp.cfDictionary()
        try Self.checkComposition(cfDictionary: cfDict)
    }

    /// Test the `[String: Any]` dictionary that is produced by `AudioAggregateDevice.Composition`.
    @Test
    func compositionDictionary() throws {
        let comp = Self.sampleComposition
        let dict = comp.dictionary()
        try Self.checkComposition(dictionary: dict)
    }

    /// Test the two `AudioAggregateDevice.Composition` instances equate.
    @Test
    func compositionEquatable() {
        let comp1 = Self.sampleComposition
        let comp2 = Self.sampleComposition
        #expect(comp1 == comp2)
    }

    /// Test the `CFDictionary` produced by an empty composition.
    @Test
    func emptyCompositionCFDictionary() {
        let comp = AudioAggregateDevice.Composition()
        let cfDict = comp.cfDictionary() as NSDictionary
        #expect(cfDict.count == 0)
    }

    /// Test decoding an empty `CFDictionary`.
    @Test
    func compositionInitFromEmptyCFDictionary() {
        let cfDict = [:] as CFDictionary
        let comp = AudioAggregateDevice.Composition(dictionary: cfDict)

        #expect(comp.uid == nil)
        #expect(comp.name == nil)
        #expect(comp.subdevices.isEmpty)
        #expect(comp.subtaps.isEmpty)
        #expect(comp.clockUID == nil)
        #expect(comp.mainSubdeviceUID == nil)
        #expect(comp.isPrivate == nil)
        #expect(comp.isStacked == nil)
        #expect(comp.isTapAutoStartEnabled == nil)
    }

    /// Test that composition dictionaries with unknown keys both parse without issue and reconstitute
    /// back into a dictionary without losing the unknown keys.
    @Test
    func unrecognizedKeys() throws {
        var dict = Self.sampleCompositionDictionary
        // add unknown key to root composition
        dict[Self.dummyUnknownKey] = "123"

        // add unknown key to a subdevice
        var subdevices = try #require(dict[kAudioAggregateDeviceSubDeviceListKey] as? [[String: Any]])
        subdevices[0][Self.dummyUnknownKey] = "456"
        dict[kAudioAggregateDeviceSubDeviceListKey] = subdevices

        // add unknown key to a tap
        var taps = try #require(dict[kAudioAggregateDeviceTapListKey] as? [[String: Any]])
        taps[0][Self.dummyUnknownKey] = "789"
        dict[kAudioAggregateDeviceTapListKey] = taps

        // ensure dictionary is parsed without issue
        let composition = AudioAggregateDevice.Composition(dictionary: dict)

        // re-create dictionary from `Composition`
        let getDict = composition.dictionary()

        // check base dictionary contents
        try Self.checkComposition(dictionary: getDict)

        // check custom root composition key
        #expect(getDict[Self.dummyUnknownKey] as? String == "123")

        // check custom subdevice key
        #expect((dict[kAudioAggregateDeviceSubDeviceListKey] as? [[String: Any]])?[0][Self.dummyUnknownKey] as? String == "456")

        // check custom tap key
        #expect((dict[kAudioAggregateDeviceTapListKey] as? [[String: Any]])?[0][Self.dummyUnknownKey] as? String == "789")
    }
}

// MARK: - Test Data

extension AudioAggregateDevice_Composition_Tests {
    static var dummyUnknownKey: String {
        "Dummy Unknown Key"
    }

    /// This produces a sample `AudioAggregateDevice.Composition` instance and also tests the
    /// member-wise initializer.
    static var sampleComposition: AudioAggregateDevice.Composition {
        AudioAggregateDevice.Composition(
            uid: .init("Dummy_UID"),
            name: "Dummy Name",
            subdevices: [
                .init(
                    uid: AudioDevice.UID("Device1_UID"),
                    name: "Device1 Name",
                    inputChannelCount: 2,
                    outputChannelCount: 4,
                    extraInputLatency: 128,
                    extraOutputLatency: 256,
                    isDriftCompensationEnabled: true,
                    driftCompensationQuality: .maximum // max == 127 (0x7F)
                ),
                .init(
                    uid: AudioDevice.UID("Device2_UID"),
                    name: "Device2 Name"
                )
            ],
            subtaps: [
                .init(
                    uid: AudioTap.UID("Tap1_UID"),
                    extraInputLatency: 128,
                    extraOutputLatency: 256,
                    isDriftCompensationEnabled: true,
                    driftCompensationQuality: .maximum // max == 127 (0x7F)
                ),
                .init(uid: AudioTap.UID("Tap2_UID"))
            ],
            clockUID: AudioClock.UID("DummyClockDevice_UID"),
            mainSubdeviceUID: AudioDevice.UID("MainSubdevice_UID"),
            isPrivate: true,
            isStacked: false,
            isTapAutoStartEnabled: false
        )
    }

    static var sampleCompositionCFDictionary: CFDictionary {
        // subdevices
        var subdevicesArray: [CFDictionary] = []

        let subdevice1 = [
            kAudioSubDeviceUIDKey as CFString: "Device1_UID" as CFString,
            kAudioSubDeviceNameKey as CFString: "Device1 Name" as CFString,
            kAudioSubDeviceInputChannelsKey as CFString: 2 as CFNumber,
            kAudioSubDeviceOutputChannelsKey as CFString: 4 as CFNumber,
            kAudioSubDeviceExtraInputLatencyKey as CFString: 128 as CFNumber,
            kAudioSubDeviceExtraOutputLatencyKey as CFString: 256 as CFNumber,
            kAudioSubDeviceDriftCompensationKey as CFString: 1 as CFNumber, // a.k.a. true
            kAudioSubDeviceDriftCompensationQualityKey as CFString: 127 as CFNumber
        ] as CFDictionary
        subdevicesArray.append(subdevice1)

        let subdevice2 = [
            kAudioSubDeviceUIDKey as CFString: "Device2_UID" as CFString,
            kAudioSubDeviceNameKey as CFString: "Device2 Name" as CFString
        ] as CFDictionary
        subdevicesArray.append(subdevice2)

        // subtaps
        var subtapsArray: [CFDictionary] = []

        let subtap1 = [
            kAudioSubTapUIDKey as CFString: "Tap1_UID" as CFString,
            kAudioSubTapExtraInputLatencyKey as CFString: 128 as CFNumber,
            kAudioSubTapExtraOutputLatencyKey as CFString: 256 as CFNumber,
            kAudioSubTapDriftCompensationKey as CFString: 1 as CFNumber, // a.k.a. true
            kAudioSubTapDriftCompensationQualityKey as CFString: 127 as CFNumber
        ] as CFDictionary
        subtapsArray.append(subtap1)

        let subtap2 = [
            kAudioSubTapUIDKey as CFString: "Tap2_UID" as CFString
        ] as CFDictionary
        subtapsArray.append(subtap2)

        // acomposition dictionary
        let compositionDict = [
            kAudioAggregateDeviceUIDKey as CFString: "Dummy_UID" as CFString,
            kAudioAggregateDeviceNameKey as CFString: "Dummy Name" as CFString,
            kAudioAggregateDeviceSubDeviceListKey as CFString: subdevicesArray as NSArray,
            kAudioAggregateDeviceTapListKey as CFString: subtapsArray as NSArray,
            kAudioAggregateDeviceClockDeviceKey as CFString: "DummyClockDevice_UID" as CFString,
            kAudioAggregateDeviceMainSubDeviceKey as CFString: "MainSubdevice_UID" as CFString,
            kAudioAggregateDeviceIsPrivateKey as CFString: 1 as CFNumber, // a.k.a. true
            kAudioAggregateDeviceIsStackedKey as CFString: 0 as CFNumber, // a.k.a. false,
            kAudioAggregateDeviceTapAutoStartKey as CFString: 0 as CFNumber // a.k.a. false,
        ] as CFDictionary

        return compositionDict
    }

    static var sampleCompositionDictionary: [String: Any] {
        // subdevices
        var subdevicesArray: [[String: Any]] = []

        let subdevice1: [String: Any] = [
            kAudioSubDeviceUIDKey: "Device1_UID",
            kAudioSubDeviceNameKey: "Device1 Name",
            kAudioSubDeviceInputChannelsKey: 2,
            kAudioSubDeviceOutputChannelsKey: 4,
            kAudioSubDeviceExtraInputLatencyKey: 128 as Double,
            kAudioSubDeviceExtraOutputLatencyKey: 256 as Double,
            kAudioSubDeviceDriftCompensationKey: true,
            kAudioSubDeviceDriftCompensationQualityKey: 127
        ]
        subdevicesArray.append(subdevice1)

        let subdevice2: [String: Any] = [
            kAudioSubDeviceUIDKey: "Device2_UID",
            kAudioSubDeviceNameKey: "Device2 Name"
        ]
        subdevicesArray.append(subdevice2)

        // subtaps
        var subtapsArray: [[String: Any]] = []

        let subtap1: [String: Any] = [
            kAudioSubTapUIDKey: "Tap1_UID",
            kAudioSubTapExtraInputLatencyKey: 128 as Double,
            kAudioSubTapExtraOutputLatencyKey: 256 as Double,
            kAudioSubTapDriftCompensationKey: true,
            kAudioSubTapDriftCompensationQualityKey: 127
        ]
        subtapsArray.append(subtap1)

        let subtap2: [String: Any] = [
            kAudioSubTapUIDKey: "Tap2_UID"
        ]
        subtapsArray.append(subtap2)

        // acomposition dictionary
        let compositionDict: [String: Any] = [
            kAudioAggregateDeviceUIDKey: "Dummy_UID",
            kAudioAggregateDeviceNameKey: "Dummy Name",
            kAudioAggregateDeviceSubDeviceListKey: subdevicesArray,
            kAudioAggregateDeviceTapListKey: subtapsArray,
            kAudioAggregateDeviceClockDeviceKey: "DummyClockDevice_UID",
            kAudioAggregateDeviceMainSubDeviceKey: "MainSubdevice_UID",
            kAudioAggregateDeviceIsPrivateKey: true,
            kAudioAggregateDeviceIsStackedKey: false,
            kAudioAggregateDeviceTapAutoStartKey: false
        ]

        return compositionDict
    }
}

// MARK: - Test Data Verification Helpers

extension AudioAggregateDevice_Composition_Tests {
    static func checkComposition(
        composition comp: AudioAggregateDevice.Composition,
        overridingUID: AudioAggregateDevice.UID? = nil
    ) throws {
        // uid
        #expect(comp.uid?.rawValue == overridingUID?.rawValue ?? "Dummy_UID")

        // name
        #expect(comp.name == "Dummy Name")

        // subdevices
        try checkSubDevices(compositionArray: comp.subdevices)

        // subtaps
        try checkSubTaps(compositionArray: comp.subtaps)

        // clock uid
        #expect(comp.clockUID?.rawValue == "DummyClockDevice_UID")

        // main subdevice uid
        #expect(comp.mainSubdeviceUID?.rawValue == "MainSubdevice_UID")

        // is private
        #expect(comp.isPrivate == true)

        // is stacked
        #expect(comp.isStacked == false)

        // is tap auto-start enabled
        #expect(comp.isTapAutoStartEnabled == false)
    }

    static func checkComposition(
        cfDictionary: CFDictionary,
        overridingUID: AudioAggregateDevice.UID? = nil
    ) throws {
        let cfDict = cfDictionary as NSDictionary

        // uid
        #expect(cfDict[kAudioAggregateDeviceUIDKey] as? String == overridingUID?.rawValue ?? "Dummy_UID")

        // name
        #expect(cfDict[kAudioAggregateDeviceNameKey] as? String == "Dummy Name")

        // subdevices
        let subdevices = try #require(cfDict[kAudioAggregateDeviceSubDeviceListKey] as? NSArray)
        try checkSubDevices(cfArray: subdevices)

        // subtaps
        let subtaps = try #require(cfDict[kAudioAggregateDeviceTapListKey] as? NSArray)
        try checkSubTaps(cfArray: subtaps)

        // clock uid
        #expect(cfDict[kAudioAggregateDeviceClockDeviceKey] as? String == "DummyClockDevice_UID")

        // main subdevice uid
        #expect(cfDict[kAudioAggregateDeviceMainSubDeviceKey] as? String == "MainSubdevice_UID")

        // is private
        #expect(cfDict[kAudioAggregateDeviceIsPrivateKey] as? Int == 1)
        #expect(cfDict[kAudioAggregateDeviceIsPrivateKey] as? Bool == true)

        // is stacked
        #expect(cfDict[kAudioAggregateDeviceIsStackedKey] as? Int == 0)
        #expect(cfDict[kAudioAggregateDeviceIsStackedKey] as? Bool == false)

        // is tap auto-start enabled
        #expect(cfDict[kAudioAggregateDeviceTapAutoStartKey] as? Int == 0)
        #expect(cfDict[kAudioAggregateDeviceTapAutoStartKey] as? Bool == false)
    }

    static func checkComposition(
        dictionary dict: [String: Any],
        overridingUID: AudioAggregateDevice.UID? = nil
    ) throws {
        // uid
        #expect(dict[kAudioAggregateDeviceUIDKey] as? String == overridingUID?.rawValue ?? "Dummy_UID")

        // name
        #expect(dict[kAudioAggregateDeviceNameKey] as? String == "Dummy Name")

        // subdevices
        let subdevices = try #require(dict[kAudioAggregateDeviceSubDeviceListKey] as? [Any])
        try checkSubDevices(array: subdevices)

        // subtaps
        let subtaps = try #require(dict[kAudioAggregateDeviceTapListKey] as? [Any])
        try checkSubTaps(array: subtaps)

        // clock uid
        #expect(dict[kAudioAggregateDeviceClockDeviceKey] as? String == "DummyClockDevice_UID")

        // main subdevice uid
        #expect(dict[kAudioAggregateDeviceMainSubDeviceKey] as? String == "MainSubdevice_UID")

        // is private
        #expect(dict[kAudioAggregateDeviceIsPrivateKey] as? Int == nil)
        #expect(dict[kAudioAggregateDeviceIsPrivateKey] as? Bool == true)

        // is stacked
        #expect(dict[kAudioAggregateDeviceIsStackedKey] as? Int == nil)
        #expect(dict[kAudioAggregateDeviceIsStackedKey] as? Bool == false)

        // is tap auto-start enabled
        #expect(dict[kAudioAggregateDeviceTapAutoStartKey] as? Int == nil)
        #expect(dict[kAudioAggregateDeviceTapAutoStartKey] as? Bool == false)
    }

    static func checkSubDevices(cfArray: CFArray) throws {
        let subdevices = try #require(cfArray as? [NSDictionary])
        try #require(subdevices.count == 2)

        // subdevice 1
        let expectedCount = subdevices[0].allKeys.compactMap { $0 as? String }.contains(Self.dummyUnknownKey) ? 8 + 1 : 8
        try #require(subdevices[0].count == expectedCount)
        #expect(subdevices[0][kAudioSubDeviceUIDKey] as? String == "Device1_UID")
        #expect(subdevices[0][kAudioSubDeviceNameKey] as? String == "Device1 Name")
        #expect(subdevices[0][kAudioSubDeviceInputChannelsKey] as? Int == 2)
        #expect(subdevices[0][kAudioSubDeviceOutputChannelsKey] as? Int == 4)
        #expect(subdevices[0][kAudioSubDeviceExtraInputLatencyKey] as? Double == 128)
        #expect(subdevices[0][kAudioSubDeviceExtraOutputLatencyKey] as? Double == 256)
        #expect(subdevices[0][kAudioSubDeviceDriftCompensationKey] as? Int == 1)
        #expect(subdevices[0][kAudioSubDeviceDriftCompensationQualityKey] as? Int == 127)

        // subdevice 2
        try #require(subdevices[1].count == 2)
        #expect(subdevices[1][kAudioSubDeviceUIDKey] as? String == "Device2_UID")
        #expect(subdevices[1][kAudioSubDeviceNameKey] as? String == "Device2 Name")
    }

    static func checkSubDevices(array: [Any]) throws {
        let subdevices = try #require(array as? [[String: Any]])
        try #require(subdevices.count == 2)

        // subdevice 1
        let expectedCount = subdevices[0].keys.contains(Self.dummyUnknownKey) ? 8 + 1 : 8
        try #require(subdevices[0].count == expectedCount)
        #expect(subdevices[0][kAudioSubDeviceUIDKey] as? String == "Device1_UID")
        #expect(subdevices[0][kAudioSubDeviceNameKey] as? String == "Device1 Name")
        #expect(subdevices[0][kAudioSubDeviceInputChannelsKey] as? Int == 2)
        #expect(subdevices[0][kAudioSubDeviceOutputChannelsKey] as? Int == 4)
        #expect(subdevices[0][kAudioSubDeviceExtraInputLatencyKey] as? Double == 128)
        #expect(subdevices[0][kAudioSubDeviceExtraOutputLatencyKey] as? Double == 256)
        #expect(subdevices[0][kAudioSubDeviceDriftCompensationKey] as? Int == nil)
        #expect(subdevices[0][kAudioSubDeviceDriftCompensationKey] as? Bool == true)
        #expect(subdevices[0][kAudioSubDeviceDriftCompensationQualityKey] as? Int == 127)

        // subdevice 2
        try #require(subdevices[1].count == 2)
        #expect(subdevices[1][kAudioSubDeviceUIDKey] as? String == "Device2_UID")
        #expect(subdevices[1][kAudioSubDeviceNameKey] as? String == "Device2 Name")
    }

    static func checkSubDevices(compositionArray subdevices: [AudioAggregateDevice.Composition.SubDevice]) throws {
        try #require(subdevices.count == 2)

        // subdevice 1
        #expect(subdevices[0].uid?.rawValue == "Device1_UID")
        #expect(subdevices[0].name == "Device1 Name")
        #expect(subdevices[0].inputChannelCount == 2)
        #expect(subdevices[0].outputChannelCount == 4)
        #expect(subdevices[0].extraInputLatency == 128)
        #expect(subdevices[0].extraOutputLatency == 256)
        #expect(subdevices[0].isDriftCompensationEnabled == true)
        #expect(subdevices[0].driftCompensationQuality == .maximum) // max == 127 (0x7F)

        // subdevice 2
        #expect(subdevices[1].uid?.rawValue == "Device2_UID")
        #expect(subdevices[1].name == "Device2 Name")
    }

    static func checkSubTaps(cfArray: CFArray) throws {
        let subtaps = try #require(cfArray as? [NSDictionary])
        try #require(subtaps.count == 2)

        // subtap 1
        let expectedCount = subtaps[0].allKeys.compactMap { $0 as? String }.contains(Self.dummyUnknownKey) ? 5 + 1 : 5
        try #require(subtaps[0].count == expectedCount)
        #expect(subtaps[0][kAudioSubTapUIDKey] as? String == "Tap1_UID")
        #expect(subtaps[0][kAudioSubTapExtraInputLatencyKey] as? Double == 128)
        #expect(subtaps[0][kAudioSubTapExtraOutputLatencyKey] as? Double == 256)
        #expect(subtaps[0][kAudioSubTapDriftCompensationKey] as? Int == 1)
        #expect(subtaps[0][kAudioSubTapDriftCompensationQualityKey] as? Int == 127)

        // subtap 2
        try #require(subtaps[1].count == 1)
        #expect(subtaps[1][kAudioSubTapUIDKey] as? String == "Tap2_UID")
    }

    static func checkSubTaps(array: [Any]) throws {
        let subtaps = try #require(array as? [[String: Any]])
        try #require(subtaps.count == 2)

        // subtap 1
        let expectedCount = subtaps[0].keys.contains(Self.dummyUnknownKey) ? 5 + 1 : 5
        try #require(subtaps[0].count == expectedCount)
        #expect(subtaps[0][kAudioSubTapUIDKey] as? String == "Tap1_UID")
        #expect(subtaps[0][kAudioSubTapExtraInputLatencyKey] as? Double == 128)
        #expect(subtaps[0][kAudioSubTapExtraOutputLatencyKey] as? Double == 256)
        #expect(subtaps[0][kAudioSubTapDriftCompensationKey] as? Int == nil)
        #expect(subtaps[0][kAudioSubTapDriftCompensationKey] as? Bool == true)
        #expect(subtaps[0][kAudioSubTapDriftCompensationQualityKey] as? Int == 127)

        // subtap 2
        try #require(subtaps[1].count == 1)
        #expect(subtaps[1][kAudioSubTapUIDKey] as? String == "Tap2_UID")
    }

    static func checkSubTaps(compositionArray subtaps: [AudioAggregateDevice.Composition.SubTap]) throws {
        try #require(subtaps.count == 2)

        // subtap 1
        #expect(subtaps[0].uid?.rawValue == "Tap1_UID")
        #expect(subtaps[0].extraInputLatency == 128)
        #expect(subtaps[0].extraOutputLatency == 256)
        #expect(subtaps[0].isDriftCompensationEnabled == true)
        #expect(subtaps[0].driftCompensationQuality == .maximum) // max == 127 (0x7F)

        // subtap 2
        #expect(subtaps[1].uid?.rawValue == "Tap2_UID")
    }
}

#endif
