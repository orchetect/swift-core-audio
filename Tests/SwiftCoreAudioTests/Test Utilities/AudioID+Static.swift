//
//  AudioID+Static.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import Foundation
import SwiftCoreAudio

extension AudioID {
    // MARK: - Random
    
    /// Random ID useful for testing an object ID that is guaranteed to not exist.
    static var randomUnused: Self {
        func newID() -> AudioObjectID {
            .random(in: 4000 ... 10000)
        }
        var id = newID()
        while (try? AudioSystem.shared.object(forID: id)) != nil {
            id = newID()
        }
        
        return Self(id)
    }
}

#endif
