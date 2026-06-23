//
//  SystemInfo.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Darwin
import Foundation

nonisolated
public enum SystemInfo {
    /// Returns the model name of the local Mac computer.
    /// Computes lazily on first access, then stores the value for subsequent accesses.
    public nonisolated static let localMachineModelName: String = _localMachineModelName()

    nonisolated
    private static func _localMachineModelName() -> String {
        let name: String
        var mib = [CTL_HW, HW_MODEL]

        // Max model name size not defined by sysctl. Instead we use io_name_t
        // via I/O Kit which can also get the model name
        var size = MemoryLayout<io_name_t>.size

        let ptr = UnsafeMutablePointer<io_name_t>.allocate(capacity: 1)
        let result = sysctl(&mib, u_int(mib.count), ptr, &size, nil, 0)

        if result == 0 {
            name = String(cString: UnsafeRawPointer(ptr).assumingMemoryBound(to: CChar.self))
        } else {
            name = String()
        }

        ptr.deallocate()

        #if DEBUG
        if result != 0 {
            Logging.log(.error, "Error retrieving model name from sysctl. Error # \(result)")
        }
        #endif

        return name
    }
}
