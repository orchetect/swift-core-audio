//
//  AudioTapProperties.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

/// Properties offered by the Core Audio `AudioTap` class.
public protocol AudioTapProperties where Self: AudioObject & UIDIdentifiableAudioObject {
    // MARK: CoreAudio/AudioHardware.h

    /// A persistent identifier string for the Tap. A Tap's UID persists until the tap is destroyed.
    nonisolated
    var tapUID: UID { get throws(SwiftCoreAudioError) }

    /// The `CATapDescription` used to initially create this tap.
    @available(macOS 12.0, macCatalyst 15.0, *)
    nonisolated
    var tapDescription: CATapDescription { get throws(SwiftCoreAudioError) }

    /// Set the `CATapDescription` for the tap to update it.
    @available(macOS 12.0, macCatalyst 15.0, *)
    nonisolated
    func setTapDescription(_ tapDescription: CATapDescription) throws(SwiftCoreAudioError)

    /// An `AudioStream/CurrentBasicDescription` instance that describes the current data format for
    /// the tap.
    ///
    /// This is the format of that data that will be accessible in any aggregate device that contains
    /// the tap.
    nonisolated
    var format: AudioStream.CurrentBasicDescription { get throws(SwiftCoreAudioError) }
}

#endif
