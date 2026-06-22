//
//  AudioObject+Listeners.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

extension AudioObject {
    /// Internal:
    /// Registers for notifications to be received for the given property for this object.
    ///
    /// This method returns a `Cancellable` object that will automatically remove the listener
    /// when the object deinits.
    nonisolated
    func _addListener(
        forProperty property: AudioProperty<some Any, some Any, some Any>,
        queue: DispatchQueue?,
        block: @escaping @Sendable () -> Void
    ) throws(SwiftCoreAudioError) -> AudioObjectPropertyListenerRef {
        let audioObjectID = id.rawValue
        
        var address = property.address
        
        let block: AudioObjectPropertyListenerBlock = { count, propertyAddressArrayPtr in
            guard count > 0 else { return }

            // ensure the property is relevant
            guard (0 ..< Int(count))
                .contains(where: { index in
                    propertyAddressArrayPtr[index].isEqual(to: address)
                })
            else { return }

            block()
        }
        try AudioObjectAddPropertyListenerBlock(
            audioObjectID,
            &address,
            queue,
            block
        )
        .audioOSStatusError()?
        .throwSwiftCoreAudioError(message: "Error adding Core Audio object listener for property \(property).")
        
        let ref = AudioObjectPropertyListenerRef(
            id: audioObjectID,
            address: address,
            queue: queue,
            listener: block
        )
        return ref
    }

    /// Internal:
    /// Registers for notifications to be received for the given property for this object and returns
    /// an `AsyncThrowingStream` that may be indefinitely iterated on within a `Task` until cancelled.
    ///
    /// The element of the sequence is simply `Void`, but a new element is produced every time the
    /// listener receives a notification.
    ///
    /// The listener is automatically removed when the stream is cancelled.
    ///
    /// For example:
    ///
    /// ```swift
    /// Task {
    ///     for try? await _ in device.listenerSequence(for: .name) {
    ///         // react to receiving notification
    ///     }
    /// }
    /// ```
    nonisolated
    func _listenerSequence(
        forProperty property: AudioProperty<some Any, some Any, some Any>
    ) -> AsyncThrowingStream<Void, any Error> {
        AsyncThrowingStream(bufferingPolicy: .unbounded) { continuation in
            do throws(SwiftCoreAudioError) {
                let listenerRef = try _addListener(forProperty: property, queue: nil) {
                    continuation.yield(())
                }
                continuation.onTermination = { @Sendable [weak listenerRef] _ in
                    listenerRef?.cancel()
                }
            } catch {
                continuation.finish(throwing: error)
            }
        }
    }
}

#endif
