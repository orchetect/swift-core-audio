//
//  BluetoothAudioProduct Tests.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import Testing
import SwiftCoreAudio

/// These are logic-only tests and do not need to be nested under ``SerializedTests``.
@Suite
struct BluetoothAudioProduct_Tests {
    init() {
        CoreAudioLogging.bootstrap()
    }

    /// Check for duplicate product ID values. They should all be unique.
    @Test
    func checkAllProductIDsAreUnique() throws {
        let ids = Set(BluetoothAudioProduct.allCases.map(\.productID))
        #expect(ids.count == BluetoothAudioProduct.allCases.count)
    }

    /// Basic spot-check to ensure `init(vendorID:productID:)` functions as expected.
    @Test
    func init_vendorID_productID_spotCheck() throws {
        #expect(BluetoothAudioProduct(vendorID: 0x0000, productID: 0x2002) == nil)
        #expect(BluetoothAudioProduct(vendorID: 0x004C, productID: 0x2002) == .airPodsGen1)
        #expect(BluetoothAudioProduct(vendorID: 0x004C, productID: 0x0000) == nil)
    }

    /// Basic spot-check to ensure the `vendorID` and `productID` instance properties function as expected.
    @Test
    func vendorID_productID_spotCheck() throws {
        #expect(BluetoothAudioProduct.airPodsGen1.vendorID == 0x004C)
        #expect(BluetoothAudioProduct.airPodsGen1.productID == 0x2002)
    }

    /// Basic spot-check to ensure `init(coreAudioDeviceModelName:)` functions as expected.
    @Test
    func init_coreAudioDeviceModelName_spotCheck() throws {
        // verbatim string that matches actual model UID string
        #expect(BluetoothAudioProduct(coreAudioDeviceModelName: "2002 4c") == .airPodsGen1)

        // allow case-insensitive matching
        #expect(BluetoothAudioProduct(coreAudioDeviceModelName: "2002 4C") == .airPodsGen1)

        // don't allow unexpected whitespace
        #expect(BluetoothAudioProduct(coreAudioDeviceModelName: " 2002 4c") == nil)
        #expect(BluetoothAudioProduct(coreAudioDeviceModelName: "2002 4c ") == nil)
        #expect(BluetoothAudioProduct(coreAudioDeviceModelName: " 2002 4c ") == nil)
        #expect(BluetoothAudioProduct(coreAudioDeviceModelName: "2002  4c") == nil)

        // invalid strings
        #expect(BluetoothAudioProduct(coreAudioDeviceModelName: "") == nil)
        #expect(BluetoothAudioProduct(coreAudioDeviceModelName: "airPodsGen1") == nil)
    }

    /// Basic spot-check to ensure the `coreAudioDeviceModelName` instance property functions as expected.
    @Test
    func coreAudioDeviceModelName_spotCheck() throws {
        #expect(BluetoothAudioProduct.airPodsGen1.coreAudioDeviceModelName == "2002 4c")
    }

    /// Basic spot-check to ensure the `systemImageName` instance property functions as expected.
    @Test
    func systemImageName_spotCheck() throws {
        #expect(!BluetoothAudioProduct.airPodsGen1.systemImageName.isEmpty)
    }
}
