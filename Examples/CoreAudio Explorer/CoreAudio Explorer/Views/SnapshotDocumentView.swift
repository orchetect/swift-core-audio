//
//  SnapshotDocumentView.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftCoreAudio
import SwiftUI

struct SnapshotDocumentView: View {
    @Binding var document: SnapshotDocument

    var body: some View {
        SnapshotView(snapshot: document.snapshot)
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Button {
                        refreshSnapshot()
                    } label: {
                        Label("Refresh", systemImage: "arrow.clockwise")
                    }
                }
            }
    }

    private func refreshSnapshot() {
        Task { document.snapshot = await AudioObjectSnapshot.system() }
    }
}

#Preview {
    @Previewable @State var document = SnapshotDocument()
    SnapshotDocumentView(document: $document)
}
