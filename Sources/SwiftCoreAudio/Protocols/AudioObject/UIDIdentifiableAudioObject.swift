//
//  UIDIdentifiableAudioObject.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

/// Audio objects that are identifiable to CoreAudio by a persistent UID string.
///
/// This identifier is passed to CoreAudio in order too look up the ephemeral numeric ID that the
/// object has been assigned for the session.
nonisolated
public protocol UIDIdentifiableAudioObject: AudioObject {
    /// Strongly-typed persistent unique identifier.
    typealias UID = AudioUID<Self>

    /// Strongly-typed persistent unique identifier.
    nonisolated
    var uid: UID { get throws(SwiftCoreAudioError) }
}

#endif
