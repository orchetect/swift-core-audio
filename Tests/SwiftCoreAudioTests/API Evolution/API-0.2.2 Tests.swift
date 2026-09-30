//
//  API-0.2.2.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import Foundation
import Testing
import SwiftCoreAudio
import SwiftProcess

/// These tests do not need to be nested under ``SerializedTests``.
@Suite
struct API_0_2_2_Tests {
    init() {
        CoreAudioLogging.bootstrap()
    }

    // MARK: - AudioDevice TransportType+Icon.swift

    /// Ensure deprecated method compiles. A deprecation warning should be emitted by the compiler.
    /// We don't care about testing the underlying logic or return value here.
    @available(macOS 11, macCatalyst 13, iOS 13, tvOS 13, watchOS 6, visionOS 1, *)
    @Test
    func audioDevice_TransportType_iconSystemName() throws {
        _ = AudioDevice.TransportType.builtIn.iconSystemName(for: .output, deviceModelName: nil)
    }

    // MARK: - AudioDeviceProperties+Icon.swift

    /// Ensure deprecated method compiles. A deprecation warning should be emitted by the compiler.
    /// We don't care about testing the underlying logic or return value here.
    @available(macOS 11, macCatalyst 13, iOS 13, tvOS 13, watchOS 6, visionOS 1, *)
    @Test
    func audioDeviceProperties_iconImageSystemName() throws {
        guard let device = try AudioSystem.shared.devices.first else {
            return
        }
        _ = try? device.iconImageSystemName(for: .output, cachedTransportType: nil, cachedModelName: nil)
    }

    /// Ensure deprecated method compiles. A deprecation warning should be emitted by the compiler.
    /// We don't care about testing the underlying logic or return value here.
    @available(macOS 11, macCatalyst 13, iOS 13, tvOS 13, watchOS 6, visionOS 1, *)
    @Test
    func audioDeviceProperties_iconImage() throws {
        guard let device = try AudioSystem.shared.devices.first else {
            return
        }
        _ = device.iconImage(
            for: .output,
            isDriverIconAllowed: true,
            cachedTransportType: nil,
            cachedModelName: nil
        )
    }
}

#endif
