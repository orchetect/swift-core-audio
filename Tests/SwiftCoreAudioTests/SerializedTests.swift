//
//  SerializedTests.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Testing
import SwiftCoreAudio

/// Test target namespace to nest all tests that should be serialized.
///
/// All suites and tests contained within extensions of this namespace will be automatically serialized as a whole
/// without having to rely on Xcode's TestPlan being set to disable test parallelization.
@Suite(.serialized)
struct SerializedTests {
    init() {
        CoreAudioLogging.bootstrap()
    }
}
