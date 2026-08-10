//
//  PollingPredicate.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import Foundation

/// Waits synchronously for the predicate to evaluate `true` with a timeout period.
/// This polls the predicate at the specified interval and blocks until the condition is met or the
/// timeout is exceeded.
struct PollingPredicate {
    typealias Predicate = () -> Bool

    private let pollingInterval: TimeInterval

    init(pollingInterval: TimeInterval = 0.05) {
        self.pollingInterval = max(pollingInterval, 0.001) // sanitize input
    }

    func wait(timeout: TimeInterval, for predicate: Predicate) -> DispatchTimeoutResult {
        guard timeout > 0.0 else { return .timedOut } // sanitize input

        let inDate = Date()
        let sleepDuration = UInt32(Double(USEC_PER_SEC) * pollingInterval)
        while !predicate() {
            usleep(sleepDuration)
            if Date().timeIntervalSince(inDate) > timeout {
                // timed out
                return .timedOut
            }
        }
        return .success
    }
}

#endif
