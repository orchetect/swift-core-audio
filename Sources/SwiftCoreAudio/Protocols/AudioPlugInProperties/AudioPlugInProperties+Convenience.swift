//
//  AudioPlugInProperties+Convenience.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

// MARK: - Properties

extension AudioPlugInProperties {
    /// Returns `true` if the plugin is present in the plugins currently available to the system.
    ///
    /// > Note: Avoid calling this method repeatedly for each element in a collection of plugins.
    /// > Instead, get the value of `AudioSystem.shared.plugIns` once and check for the presence of
    /// > each plugin in the returned array.
    nonisolated
    public var isPresent: Bool {
        // TODO: there may be a direct Core Audio call that can do this faster than this method...
        guard let ids = try? AudioSystem.shared.plugIns.map(\.id) else { return false }
        return ids // TODO: can simplify if `AnyAudioPlugIn` type is implemented
            .map(\.rawValue)
            .contains(id.rawValue)
    }
}

#endif
