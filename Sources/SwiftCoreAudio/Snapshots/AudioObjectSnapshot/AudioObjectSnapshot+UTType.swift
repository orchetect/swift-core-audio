//
//  AudioObjectSnapshot+UTType.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import UniformTypeIdentifiers
import Foundation

@available(macOS 11.0, iOS 14.0, watchOS 7.0, tvOS 14.0, *)
extension UTType {
    /// UT Type for ``AudioObjectSnapshot``'s encoded data format, with filename extension `coreaudiosnapshot`.
    public static let coreAudioSnapshot = UTType(exportedAs: "com.orchetect.SwiftCoreAudio.Snapshot")
}

#endif
