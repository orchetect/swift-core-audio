//
//  AudioTapProperties+Implementation.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

// MARK: - Tap Lifecycle

extension AudioTapProperties {
    /// Destroys the tap.
    ///
    /// Convenience for calling ``AudioSystem/destroyTap(_:)`` on ``AudioSystem``.
    @available(macOS 14.2, *)
    @available(macCatalyst, unavailable)
    nonisolated
    public func destroy() throws(SwiftCoreAudioError) {
        try AudioSystem.shared.destroyTap(self)
    }
}

// MARK: - Properties

extension AudioTapProperties {
    /// Returns `true` if the tap is present in the taps currently available to the system.
    ///
    /// > Note: Avoid calling this method repeatedly for each element in a collection of taps.
    /// > Instead, get the value of `AudioSystem.shared.taps` once and check for the presence of
    /// > each tap in the returned array.
    nonisolated
    public var isPresent: Bool {
        // TODO: there may be a direct Core Audio call that can do this faster than this method...
        guard let ids = try? AudioSystem.shared.taps.map(\.id.rawValue) else { return false }
        return ids.contains(id.rawValue)
    }
}

// MARK: - Set

extension AudioTapProperties {
    /// Set the audio processes used by the tap.
    ///
    /// Convenience to get the `CATapDescription` for the tap, update its contents, and re-set it.
    @available(macOS 26.0, macCatalyst 26.0, iOS 15.0, *)
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    nonisolated
    public func setBundleIDs(_ bundleIDs: [BundleID]) throws(SwiftCoreAudioError) {
        // `bundleIDs` property does not exist in the SDK when building with Xcode older than Xcode 26
        #if compiler(>=6.3)
        let tapDescription = try tapDescription
        tapDescription.bundleIDs = bundleIDs.map(\.rawValue)
        try setTapDescription(tapDescription)
        #else
        throw .failedToLookupAggregateComposition(message: "BundleIDs property is not supported prior to macOS 26.")
        #endif
    }
    
    /// Set the audio processes used by the tap.
    ///
    /// Convenience to get the `CATapDescription` for the tap, update its contents, and re-set it.
    @available(macOS 14.0, /* macCatalyst 17.0, */ iOS 17.0, tvOS 17.0, watchOS 1.0, *)
    @available(macCatalyst, unavailable)
    nonisolated
    public func setProcesses(_ audioProcesses: [some AudioProcessProperties]) throws(SwiftCoreAudioError) {
        // `proceses` property does not even exist on Mac Catalyst, so we have to block this out
        #if !targetEnvironment(macCatalyst)
        let tapDescription = try tapDescription
        tapDescription.processes = audioProcesses.map(\.id.rawValue)
        try setTapDescription(tapDescription)
        #endif
    }
}

#endif
