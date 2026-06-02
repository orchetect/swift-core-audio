//
//  AudioAggregateDevice+AudioDeviceProperties Tests.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import Foundation
import SwiftCoreAudio
import Testing

extension SerializedTests {
    /// Test select properties inherited from ``AudioDeviceProperties`` conformance.
    /// This does not have to be exhaustive.
    @Suite
    struct AudioAggregateDevice_AudioDeviceProperties_Tests {
        // empty for now; add tests as-needed
    }
}

#endif
