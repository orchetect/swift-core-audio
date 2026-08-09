//
//  AudioDevicePresence.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import Foundation

/// Waits synchronously for the predicate to evaluate `true` with a timeout period.
/// This works on a reactive model by watching Core Audio notifications.
actor AsyncAudioDevicesPresence {
    typealias Predicate = (_ devices: [AnyAudioDevice]) -> Bool

    private let pollingInterval: TimeInterval
    private var timer: Task<Void, any Error>?
    var devices: [AnyAudioDevice] = []

    init(pollingInterval: TimeInterval = 0.01) {
        self.pollingInterval = max(pollingInterval, 0.001) // sanitize input
    }

    deinit {
        timer?.cancel()
        timer = nil
    }

    /// Starts receiving Core Audio devices change notifications.
    func start() {
        stop()
        updateDevices()
        timer = timerFactory()
    }

    func stop() {
        timer?.cancel()
        timer = nil
    }

    var isStarted: Bool {
        timer != nil
    }

    /// Waits synchronously for the predicate to evaluate `true` with a timeout.
    func wait(timeout: TimeInterval, for predicate: Predicate) async -> DispatchTimeoutResult {
        if !isStarted { start() }
        guard timeout > 0.0 else { return .timedOut } // sanitize input

        let inDate = Date()
        let sleepDuration = UInt64(TimeInterval(NSEC_PER_SEC) * pollingInterval)
        while !predicate(devices) {
            // check for task cancellation
            if Task.isCancelled { return .timedOut }

            // wait polling duration
            try? await Task.sleep(nanoseconds: sleepDuration)
            if Date().timeIntervalSince(inDate) > timeout {
                // timed out
                return .timedOut
            }
        }
        return .success
    }

    private func updateDevices() {
        guard let devices = try? AudioSystem.shared.devices else { return }
        self.devices = devices
    }

    private func timerFactory() -> Task<Void, any Error> {
        Task { [weak self] in
            for try await _ in AudioSystem.shared.listenerSequence(for: .devices) {
                await self?.updateDevices()
            }
            await self?.stop()
        }
    }
}

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
