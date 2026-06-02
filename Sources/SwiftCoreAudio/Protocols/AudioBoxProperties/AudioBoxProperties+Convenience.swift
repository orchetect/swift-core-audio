//
//  AudioBoxProperties+Convenience.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

// MARK: - Properties

extension AudioBoxProperties {
    /// Returns `true` if the box is present in the boxes currently available to the system.
    ///
    /// > Note: Avoid calling this method repeatedly for each element in a collection of boxes.
    /// > Instead, get the value of `AudioSystem.shared.boxes` once and check for the presence of
    /// > each box in the returned array.
    nonisolated
    public var isPresent: Bool {
        // TODO: there may be a direct Core Audio call that can do this faster than this method...
        guard let ids = try? AudioSystem.shared.boxes.map(\.id.rawValue) else { return false }
        return ids.contains(id.rawValue)
    }
}

#endif
