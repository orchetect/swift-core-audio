//
//  SnapshotsModel.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftCoreAudio
import SwiftUI

@Observable
final class SnapshotsModel {
    @MainActor
    var snapshots: [AudioObjectSnapshot] = []

    @MainActor
    var selectedSnapshot: AudioObjectSnapshot?

    nonisolated
    init() { }
}

extension SnapshotsModel {
    enum SelectionBehavior: Equatable, Hashable, Sendable {
        case first
        case currentlySelectedIfPossible
    }

    @concurrent
    func update(from snapshots: [AudioObjectSnapshot], select selectionBehavior: SelectionBehavior) async {
        await MainActor.run {
            let currentSelectedSnapshot = selectedSnapshot

            self.snapshots = snapshots

            switch selectionBehavior {
            case .first:
                selectedSnapshot = snapshots.first
            case .currentlySelectedIfPossible:
                if let snapshot = currentSelectedSnapshot,
                   !snapshots.contains(snapshot)
                {
                    // default back to first
                    selectedSnapshot = snapshots.first
                }
            }
        }
    }
}

extension SnapshotsModel {
    func name(for snapshot: AudioObjectSnapshot?) -> String {
        let defaultName = "Untitled Snapshot"
        guard let snapshot else {
            return defaultName
        }
        return snapshot.date.autoSizedFormatted
    }
}
