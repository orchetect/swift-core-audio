//
//  SnapshotsDocumentView.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftCoreAudio
import SwiftUI
import UniformTypeIdentifiers

struct SnapshotsDocumentView: View {
    @Binding var document: SnapshotsDocument
    @State private var model = SnapshotsModel()

    @Environment(\.newDocument) private var newDocument

    var body: some View {
        SnapshotView(snapshot: model.selectedSnapshot)
            .onAppear {
                Task {
                    await model.update(from: document.snapshots, select: .first)
                }
            }
            .onChange(of: document.snapshots) { oldValue, newValue in
                Task {
                    await model.update(from: newValue, select: .currentlySelectedIfPossible)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Picker("Snapshots", selection: $model.selectedSnapshot) {
                        ForEach(model.snapshots) { snapshot in
                            HStack {
                                Image(systemName: "camera")
                                Text(model.name(for: snapshot))
                            }
                            .tag(snapshot)
                        }
                    }
                }
                .hidden(model.snapshots.isEmpty)

                ToolbarItem(placement: .navigation) {
                    Button {
                        newSnapshot()
                    } label: {
                        Label("New Snapshot", systemImage: "camera.shutter.button.fill")
                    }
                }

                ToolbarItem(placement: .navigation) {
                    Button {
                        newDocumentFromCurrentSnapshot()
                    } label: {
                        Label("Open in New Document", systemImage: "square.and.arrow.up.on.square")
                    }
                    .disabled(model.selectedSnapshot == nil)
                }
            }
    }

    private func newSnapshot() {
        Task {
            let snapshot = await AudioObjectSnapshot.system()
            document.snapshots.append(snapshot)
            model.selectedSnapshot = snapshot
        }
    }

    private func newDocumentFromCurrentSnapshot() {
        guard let selectedSnapshot = model.selectedSnapshot else { return }
        let newSnapshotDocument = SnapshotDocument(snapshot: selectedSnapshot)

        newDocument(newSnapshotDocument)
    }
}

#Preview {
    @Previewable @State var document = SnapshotsDocument()
    SnapshotsDocumentView(document: $document)
}
