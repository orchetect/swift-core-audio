//
//  BundleID+Static.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import Foundation
import SwiftCoreAudio
import SwiftProcess

extension BundleID {
    // MARK: - Random
    
    /// Random bundle ID useful for testing a bundle ID that is guaranteed to not exist.
    static var random: Self {
        let string = "com.random.\(UUID().uuidString)"
        return BundleID(string)
    }
}

#endif
