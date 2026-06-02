//
//  AudioObjectPropertyListenerRef.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

/// A cancellable reference to a Core Audio object listener.
///
/// This object is a token returned when calling `listener(for:)` on an audio object.
///
/// The listener will be automatically removed when this object deinits.
///
/// Alternatively, the listener may be cancelled by calling `cancel()`.
nonisolated
public final class AudioObjectPropertyListenerRef: Sendable {
    let id: AudioObjectID
    let address: AudioObjectPropertyAddress
    let queue: DispatchQueue?
    nonisolated(unsafe) let listener: AudioObjectPropertyListenerBlock
    
    /// Internal init.
    init(
        id: AudioObjectID,
        address: AudioObjectPropertyAddress,
        queue: DispatchQueue?,
        listener: @escaping AudioObjectPropertyListenerBlock
    ) {
        self.id = id
        self.address = address
        self.queue = queue
        self.listener = listener
    }
    
    deinit {
        try? removeListener()
    }
    
    func removeListener() throws {
        var address = address
        try AudioObjectRemovePropertyListenerBlock(
            id,
            &address,
            queue,
            listener
        )
        .audioOSStatusError()?
        .throwSwiftCoreAudioError(message: "Error removing Core Audio object listener for address \(address).")
    }
}

#if canImport(Combine)

import Combine

nonisolated
extension AudioObjectPropertyListenerRef: Cancellable {
    public func cancel() {
        try? removeListener()
    }
}

#endif

#endif
