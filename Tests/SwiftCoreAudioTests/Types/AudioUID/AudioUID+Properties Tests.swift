//
//  AudioUID+Properties Tests.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import Testing
import SwiftCoreAudio

/// These are logic-only tests and do not need to be nested under ``SerializedTests``.
@Suite
struct AudioUID_Properties_Tests {
    init() {
        CoreAudioLogging.bootstrap()
    }
    
    @Test
    func isBlackHole() throws {
        #expect(AudioUID<AnyAudioDevice>("BlackHole2ch_UID").isBlackHole)
        #expect(AudioUID<AnyAudioDevice>("BlackHole16ch_UID").isBlackHole)
        #expect(AudioUID<AnyAudioDevice>("BlackHole32ch_UID").isBlackHole)
        #expect(AudioUID<AnyAudioDevice>("BlackHole64ch_UID").isBlackHole)
        #expect(AudioUID<AnyAudioDevice>("BlackHole128ch_UID").isBlackHole)
        #expect(AudioUID<AnyAudioDevice>("BlackHole256ch_UID").isBlackHole)

        #expect(!AudioUID<AnyAudioDevice>("BlackHole").isBlackHole)
        #expect(!AudioUID<AnyAudioDevice>("BlackHole_UID").isBlackHole)
        #expect(!AudioUID<AnyAudioDevice>("BlackHole2Ch_UID").isBlackHole)
        #expect(!AudioUID<AnyAudioDevice>("BlackHole2CH_UID").isBlackHole)
    }
}
