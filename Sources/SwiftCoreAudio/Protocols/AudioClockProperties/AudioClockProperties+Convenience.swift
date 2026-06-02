//
//  AudioClockProperties+Convenience.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

// MARK: - Properties

extension AudioClockProperties {
    /// Returns `true` if the clock is present in the clocks currently available to the system.
    ///
    /// > Note: Avoid calling this method repeatedly for each element in a collection of clocks.
    /// > Instead, get the value of `AudioSystem.shared.clocks` once and check for the presence of
    /// > each clock in the returned array.
    nonisolated
    public var isPresent: Bool {
        // TODO: there may be a direct Core Audio call that can do this faster than this method...
        guard let ids = try? AudioSystem.shared.clocks.map(\.id.rawValue) else { return false }
        return ids.contains(id.rawValue)
    }
}

#endif
