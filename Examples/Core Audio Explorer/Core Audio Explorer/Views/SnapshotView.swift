//
//  SnapshotView.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftUI
import SwiftCoreAudio

struct SnapshotView: View {
    let snapshot: AudioObjectSnapshot?
    
    @State private var model = SnapshotModel()
    
    var body: some View {
        NavigationSplitView {
            SnapshotSidebarView(model: model)
                .searchable(text: $model.sidebarSearchText, placement: .sidebar)
                .navigationSplitViewColumnWidth(min: 200, ideal: 250, max: 500)
        } detail: {
            SnapshotDetailView(snapshots: model.selectedChildren, isMainSnapshotEmpty: isSnapshotEmpty, searchText: $model.propertiesSearchText)
                .searchable(text: $model.propertiesSearchText, placement: .toolbar)
        }
        .navigationSubtitle(model.nameForSelectedChildren() ?? "")
        .onChange(of: snapshot, initial: true) { _, newValue in
            Task { await model.update(from: newValue) }
        }
    }
    
    private var isSnapshotEmpty: Bool {
        guard let snapshot else { return true }
        return snapshot.isEmpty
    }
}

#Preview {
    @Previewable @State var document = SnapshotDocument()
    SnapshotDocumentView(document: $document)
}
