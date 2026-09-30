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

    @FocusState private var isFocused
    @FocusState private var isSearchFocused

    var body: some View {
        bodyContent
            .focused($isFocused)
            .searchFocused($isSearchFocused)
            .simultaneousGesture(
                // somewhat hacky workaround to remove focus from Search fields.
                // for some reason (possibly a SwiftUI bug/quirk), focus is not removed from Search fields.
                // there is probably a cleaner way to do this idiomatically for SwiftUI, but this gets the job done.
                // `onTapGesture { }` is not enough; a simultaneous gesture is needed.
                TapGesture()
                    .onEnded { _ in
                        isFocused = true
                    }
            )
    }

    @ViewBuilder
    private var bodyContent: some View {
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
