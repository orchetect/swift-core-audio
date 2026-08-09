//
//  AsyncAudioPropertyCache.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import Foundation

/// Waits synchronously for the predicate to evaluate `true` with a timeout period.
/// This works on a reactive model by watching Core Audio notifications.
actor AsyncAudioPropertyCache<Value> {
    typealias Predicate = @Sendable (_ value: Value) -> Bool

    private let pollingInterval: TimeInterval
    private let fetchValue: () -> Value
    private let listenerSequence: @Sendable (_ cache: AsyncAudioPropertyCache<Value>) async throws -> Void

    private var task: Task<Void, any Error>?
    private(set) var cache: Value

    init(
        pollingInterval: TimeInterval = 0.01,
        fetchValue: @escaping () -> Value,
        listenerSequence: @escaping @Sendable (_ cache: AsyncAudioPropertyCache<Value>) async throws -> Void
    ) {
        self.pollingInterval = max(pollingInterval, 0.001) // sanitize input
        self.fetchValue = fetchValue
        self.listenerSequence = listenerSequence
        cache = fetchValue()
    }

    deinit {
        task?.cancel()
        task = nil
    }

    /// Starts receiving Core Audio devices change notifications.
    func start() {
        stop()
        task = timerFactory()
    }

    func stop() {
        task?.cancel()
        task = nil
    }

    var isStarted: Bool {
        task != nil
    }

    /// Waits synchronously for the predicate to evaluate `true` with a timeout.
    func wait(timeout: TimeInterval, for predicate: Predicate) async -> DispatchTimeoutResult {
        if !isStarted { start() }
        guard timeout > 0.0 else { return .timedOut } // sanitize input

        let inDate = Date()
        let sleepDuration = UInt64(TimeInterval(NSEC_PER_SEC) * pollingInterval)
        while !predicate(cache) {
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

    func updateCache() {
        cache = fetchValue()
    }

    private func timerFactory() -> Task<Void, any Error> {
        Task {
            try await listenerSequence(self)
            stop()
        }
    }
}

extension AsyncAudioPropertyCache where Value == [AnyAudioDevice] {
    /// AudioSystem devices cache.
    static func devices(pollingInterval: TimeInterval = 0.01) -> Self {
        Self(pollingInterval: pollingInterval) {
            guard let value = try? AudioSystem.shared.devices else { return [] }
            return value
        } listenerSequence: { cache in
            for try await _ in AudioSystem.shared.listenerSequence(for: .devices) {
                await cache.updateCache()
            }
        }
    }
}

extension AsyncAudioPropertyCache where Value == Bool? {
    /// AudioBox enabled state cache.
    static func audioBoxEnabled(for audioBox: some AudioBoxProperties, pollingInterval: TimeInterval = 0.01) -> Self {
        Self(pollingInterval: pollingInterval) {
            try? audioBox.isEnabled
        } listenerSequence: { cache in
            for try await _ in audioBox.listenerSequence(for: .acquired) {
                await cache.updateCache()
            }
        }
    }
}

#endif
