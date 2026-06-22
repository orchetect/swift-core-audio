//
//  SnapshotDetailView.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftCoreAudio
import SwiftUI

struct SnapshotDetailView: View {
    let snapshots: [AudioObjectSnapshot]
    let isMainSnapshotEmpty: Bool
    @Binding var searchText: String

    var body: some View {
        if snapshots.isEmpty {
            if isMainSnapshotEmpty {
                FillerInfoView(
                    systemImage: "camera.metering.unknown",
                    title: "Snapshot is empty."
                )
            } else {
                FillerInfoView(
                    systemImage: AudioObjectClassID.object.systemImageName,
                    title: "Select an object."
                )
            }
        } else {
            HStack {
                ForEach(snapshots.prefix(5)) { snapshot in
                    VStack {
                        if snapshots.count > 1 {
                            Text("\(snapshot.properties[.object(.name)] ?? "Unknown Object") (\(snapshot.objectID))")
                                .font(.title3)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(10)
                        }
                        FilterablePropertiesView(snapshot: snapshot, searchText: $searchText)
                    }
                }
            }
        }
    }
}
