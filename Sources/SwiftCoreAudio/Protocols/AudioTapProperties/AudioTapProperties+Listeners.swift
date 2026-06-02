//
//  AudioTapProperties+Listeners.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

extension AudioTapProperties {
    /// Registers for notifications to be received for the given property for this object.
    ///
    /// This method returns a `Cancellable` object that will automatically remove the listener
    /// when the object deinits.
    nonisolated
    public func listener(
        for property: TapProperty<some Any, some Any>,
        queue: DispatchQueue? = nil,
        block: @escaping @Sendable () -> Void
    ) throws(SwiftCoreAudioError) -> AudioObjectPropertyListenerRef {
        try _addListener(forProperty: property, queue: queue, block: block)
    }
    
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
    public func listenerSequence(
        for property: TapProperty<some Any, some Any>,
    ) -> AsyncThrowingStream<Void, any Error> {
        _listenerSequence(forProperty: property)
    }
}

#endif
