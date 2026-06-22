//
//  AudioTransportManagerProperties+Convenience.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

// MARK: - Properties

extension AudioTransportManagerProperties {
    /// Returns `true` if the transport manager is present in the managers currently available to the system.
    ///
    /// > Note: Avoid calling this method repeatedly for each element in a collection of managers.
    /// > Instead, get the value of `AudioSystem.shared.transportManagers` once and check for the presence of
    /// > each manager in the returned array.
    nonisolated
    public var isPresent: Bool {
        // TODO: there may be a direct Core Audio call that can do this faster than this method...
        guard let ids = try? AudioSystem.shared.transportManagers.map(\.id.rawValue) else { return false }
        return ids.contains(id.rawValue)
    }
}

#endif
