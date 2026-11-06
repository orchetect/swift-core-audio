//
//  AudioSystem+Listeners Tests.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import Foundation
import SwiftCoreAudio
import Testing
import TestingExtensions

extension SerializedTests {
    @Suite
    struct AudioSystem_Listeners_Tests {
        init() {
            CoreAudioLogging.bootstrap()
        }

        // MARK: - listener

        /// Spins up a listener for a specific property on AudioSystem.
        /// Expects that the listener is not called because the property is not changed.
        @Test
        func listener_devices_noNotifications() async throws {
            let receiver = Receiver<Void>()

            // create a listener
            let listener = try AudioSystem.shared.listener(for: .devices) {
                Task { await receiver.add(()) }
            }
            defer { listener.cancel() } // cleanup when out of scope

            // allow some time in case listener is called
            try await Task.sleep(for: .milliseconds(500))

            // expect that the listener was never called since the property didn't change
            await wait(expect: { await receiver.items.count == 0 }, timeout: 10.0)
        }

        /// Spins up a listener for a specific property on AudioSystem.
        /// Expects that the listener is called following a change to the property.
        @Test
        func listener_devices_withNotification() async throws {
            let receiver = Receiver<Void>()

            // create a listener
            let listener = try AudioSystem.shared.listener(for: .devices) {
                Task { await receiver.add(()) }
            }
            defer { listener.cancel() } // cleanup when out of scope

            // allow some time in case listener is called
            try await Task.sleep(for: .milliseconds(500))

            // expect that the listener was never called since none of its properties changed
            await wait(expect: { await receiver.items.count == 0 }, timeout: 10.0)

            // create an aggregate device
            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try await AudioSystem.shared.makeAggregateDevice(withUID: aggregateUID, isPrivate: true)
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope

            // expect the listener to have been called once
            await wait(expect: { await receiver.items.count == 1 }, timeout: 10.0)
        }

        /// Spins up a listener for a specific property on AudioSystem.
        /// Expects that the listener is not called following a change to an unrelated property.
        @Test
        func listener_unrelatedProperty() async throws {
            let receiver = Receiver<Void>()

            // create a listener
            let listener = try AudioSystem.shared.listener(for: .taps) {
                Task { await receiver.add(()) }
            }
            defer { listener.cancel() } // cleanup when out of scope

            // allow some time in case listener is called
            try await Task.sleep(for: .milliseconds(500))

            // expect that the listener was never called since none of its properties changed
            await wait(expect: { await receiver.items.count == 0 }, timeout: 10.0)

            // create an aggregate device
            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try await AudioSystem.shared.makeAggregateDevice(withUID: aggregateUID, isPrivate: true)
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope

            // expect that the listener was never called since an unrelated property changed
            await wait(expect: { await receiver.items.count == 0 }, timeout: 10.0)
        }

        /// Spins up a listener for all properties (wildcard) on AudioSystem.
        /// Expects that the listener is called following a change to the property.
        @Test
        func listener_wildcard() async throws {
            let receiver = Receiver<Void>()

            // create a listener
            let listener = try AudioSystem.shared.listener(for: .wildcard) {
                Task { await receiver.add(()) }
            }
            defer { listener.cancel() } // cleanup when out of scope

            // allow some time in case listener is called
            try await Task.sleep(for: .milliseconds(500))

            // expect that the listener was never called since none of its properties changed
            await wait(expect: { await receiver.items.count == 0 }, timeout: 10.0)

            // create an aggregate device
            let aggregateUID: AudioAggregateDevice.UID = .random
            let aggregate = try await AudioSystem.shared.makeAggregateDevice(withUID: aggregateUID, isPrivate: true)
            defer { try? AudioSystem.shared.destroyAggregateDevice(aggregate) } // cleanup when out of scope

            // expect the listener to have been called once
            await wait(expect: { await receiver.items.count == 1 }, timeout: 10.0)
        }
    }
}

#endif
