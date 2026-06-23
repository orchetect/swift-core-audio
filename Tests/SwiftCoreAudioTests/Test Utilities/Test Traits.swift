//
//  Test Traits.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import SwiftCoreAudio
import Testing

extension Trait where Self == Testing.ConditionTrait {
    /// Constructs a condition trait that disables a test if the specified audio box is not present in the system.
    static func enabledIfAudioBoxIsPresent(_ audioBox: AudioBox?) -> ConditionTrait {
        .enabled(if: audioBox?.isPresent ?? false)
    }

    /// Constructs a condition trait that disables a test if the specified audio box is not present in the system.
    static func enabledIfAudioBoxIsPresent(withUID uid: AudioBox.UID) -> ConditionTrait {
        .enabled(if: (try? AudioBox(uid: uid))?.isPresent ?? false)
    }

    /// Constructs a condition trait that disables a test if the specified audio device is not present in the system.
    static func enabledIfAudioDeviceIsPresent(_ audioDevice: AudioDevice?) -> ConditionTrait {
        .enabled(if: audioDevice?.isPresent ?? false)
    }

    /// Constructs a condition trait that disables a test if the specified audio device is not present in the system.
    static func enabledIfAudioDeviceIsPresent(withUID uid: (some AudioDeviceProperties).UID) -> ConditionTrait {
        .enabled(if: (try? uid.asAnyAudioDeviceUID.object)?.isPresent ?? false)
    }
}

#endif
