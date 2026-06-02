//
//  PID+Static.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import Foundation
import SwiftCoreAudio
import SwiftProcess

extension PID {
    // MARK: - Random
    
    /// Random PID useful for testing a PID that is guaranteed to not exist.
    static var randomUnused: Self {
        func newPID() -> PID {
            PID(rawValue: .random(in: 4000 ... 10000))
        }
        var pid = newPID()
        while let pids = try? PID.all, pids.contains(pid) {
            pid = newPID()
        }
        
        return pid
    }
}

#endif
