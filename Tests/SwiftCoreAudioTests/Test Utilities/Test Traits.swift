//
//  Test Traits.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import SwiftCoreAudio
import Testing

extension Trait where Self == Testing.ConditionTrait {
    /// Constructs a condition trait that disables a test if the specified audio box is not present in the system.
    static func enabledIfAudioBoxPresent(_ audioBox: AudioBox?) -> ConditionTrait {
        .enabled(if: audioBox?.isPresent ?? false)
    }
    
    /// Constructs a condition trait that disables a test if the specified audio device is not present in the system.
    static func enabledIfAudioDevicePresent(_ audioDevice: AudioDevice?) -> ConditionTrait {
        .enabled(if: audioDevice?.isPresent ?? false)
    }
}

#endif
