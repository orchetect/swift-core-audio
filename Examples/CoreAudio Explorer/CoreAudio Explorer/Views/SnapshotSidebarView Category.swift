//
//  SnapshotSidebarView Category.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftCoreAudio
import SwiftUI

extension SnapshotSidebarView {
    struct Category {
        let classID: AudioObjectClassID
        var snapshots: [AudioObjectSnapshot]

        init(classID: AudioObjectClassID, snapshots: [AudioObjectSnapshot] = []) {
            self.classID = classID
            self.snapshots = snapshots
        }

        var name: String {
            classID.pluralName
        }
    }
}

extension SnapshotSidebarView.Category: Equatable { }

extension SnapshotSidebarView.Category: Hashable { }

extension SnapshotSidebarView.Category: Sendable { }

extension SnapshotSidebarView.Category: Identifiable {
    var id: String {
        name
    }
}
