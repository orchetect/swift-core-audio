//
//  AudioObjectSnapshot+Properties.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

extension AudioObjectSnapshot {
    /// Returns `true` if the snapshot is empty (contains no properties, child snapshots or errors).
    public var isEmpty: Bool {
        properties.isEmpty
            && children.isEmpty
            && errors.isEmpty
    }
}

#endif
