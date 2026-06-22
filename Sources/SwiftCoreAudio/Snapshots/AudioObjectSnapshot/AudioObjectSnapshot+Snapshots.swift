//
//  AudioObjectSnapshot+Snapshots.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

// MARK: - Property Snapshots

extension AudioObjectSnapshot {
    static func _properties(of object: some AudioObject) -> [AnyPropertyKey: String] {
        AnyPropertyKey.allCases.reduce(into: [:]) { properties, key in
            properties[key] = key.getValue(of: object)
        }
    }

    // This method is functionally identical to the one above it, except it uses concurrency for improved performance
    static func _properties(of object: some AudioObject) async -> [AnyPropertyKey: String] {
        await withTaskGroup(of: (AnyPropertyKey, String?).self, returning: [AnyPropertyKey: String].self) { group in
            var results: [AnyPropertyKey: String] = [:]

            for key in AnyPropertyKey.allCases {
                group.addTask {
                    (key, key.getValue(of: object))
                }
            }

            for await (key, value) in group {
                if let value { results[key] = value }
            }

            return results
        }
    }
}

// MARK: - Child Snapshots

extension AudioObjectSnapshot {
    static func _children(of object: some AudioObject) -> [AudioObjectSnapshot] {
        var children: [AudioObjectSnapshot] = []

        if object.id.rawValue == AudioSystem.shared.id.rawValue {
            // if object is System (topmost object), treat it differently

            let devices = (try? AudioSystem.shared.devices) ?? []
            let deviceSnapshots = Self._snapshots(of: devices)

            let boxes = (try? AudioSystem.shared.boxes) ?? []
            let boxSnapshots = Self._snapshots(of: boxes)

            let clocks = (try? AudioSystem.shared.clocks) ?? []
            let clockSnapshots = Self._snapshots(of: clocks)

            let taps = (try? AudioSystem.shared.taps) ?? []
            let tapSnapshots = Self._snapshots(of: taps)

            let processes = (try? AudioSystem.shared.processes) ?? []
            let processSnapshots = Self._snapshots(of: processes)

            let plugins = (try? AudioSystem.shared.plugIns) ?? []
            let pluginSnapshots = Self._snapshots(of: plugins)

            let transportManagers = (try? AudioSystem.shared.transportManagers) ?? []
            let transportManagerSnapshots = Self._snapshots(of: transportManagers)

            let snapshots = deviceSnapshots + boxSnapshots + clockSnapshots + tapSnapshots
                + processSnapshots + pluginSnapshots + transportManagerSnapshots
            children = snapshots
        } else {
            // it's an audio object that isn't the System
            children = [] // TODO: parse children
        }

        return children
    }

    // This method is functionally identical to the one above it, except it uses concurrency for improved performance
    static func _children(of object: some AudioObject) async -> [AudioObjectSnapshot] {
        var children: [AudioObjectSnapshot] = []

        if object.id.rawValue == AudioSystem.shared.id.rawValue {
            // if object is System (topmost object), treat it differently

            let devices = (try? AudioSystem.shared.devices) ?? []
            async let deviceSnapshots = Self._snapshots(of: devices)

            let boxes = (try? AudioSystem.shared.boxes) ?? []
            async let boxSnapshots = Self._snapshots(of: boxes)

            let clocks = (try? AudioSystem.shared.clocks) ?? []
            async let clockSnapshots = Self._snapshots(of: clocks)

            let taps = (try? AudioSystem.shared.taps) ?? []
            async let tapSnapshots = Self._snapshots(of: taps)

            let processes = (try? AudioSystem.shared.processes) ?? []
            async let processSnapshots = Self._snapshots(of: processes)

            let plugins = (try? AudioSystem.shared.plugIns) ?? []
            async let pluginSnapshots = Self._snapshots(of: plugins)

            let transportManagers = (try? AudioSystem.shared.transportManagers) ?? []
            async let transportManagerSnapshots = Self._snapshots(of: transportManagers)

            let snapshots = await deviceSnapshots + boxSnapshots + clockSnapshots + tapSnapshots
                + processSnapshots + pluginSnapshots + transportManagerSnapshots
            children = snapshots
        } else {
            // it's an audio object that isn't the System
            children = [] // TODO: parse children
        }

        return children
    }
}

// MARK: - Snapshots

extension AudioObjectSnapshot {
    static func _snapshots(of objects: [some AudioObject]) -> [AudioObjectSnapshot] {
        objects.map { object in
            AudioObjectSnapshot(of: object)
        }
    }

    // This method is functionally identical to the one above it, except it uses concurrency for improved performance.
    static func _snapshots(of objects: [some AudioObject]) async -> [AudioObjectSnapshot] {
        await withTaskGroup(of: (Int, AudioObjectSnapshot).self, returning: [AudioObjectSnapshot].self) { group in
            // keep final array ordered the same by tracking indexes
            var results: [Int: AudioObjectSnapshot] = [:]

            for (index, object) in objects.enumerated() {
                group.addTask {
                    let snapshot = await AudioObjectSnapshot(of: object)
                    return (index, snapshot)
                }
            }

            for await (index, snapshot) in group {
                results[index] = snapshot
            }

            // reassemble array in correct order
            return results
                .sorted(by: { $0.key < $1.key })
                .map(\.value)
        }
    }
}

#endif
