//
//  CoreAudioExplorerApp.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftUI
import UniformTypeIdentifiers

@main
struct CoreAudioExplorerApp: App {
    @Environment(\.newDocument) private var newDocument
    
    var body: some Scene {
        DocumentGroup(newDocument: SnapshotDocument()) { file in
            SnapshotDocumentView(document: file.$document)
        }
        .defaultSize(width: 850, height: 800)
        
        DocumentGroup(newDocument: SnapshotsDocument()) { file in
            SnapshotsDocumentView(document: file.$document)
        }
        .defaultSize(width: 1250, height: 900)
        
        /// We have to add a New Document menu command manually for additional document type(s)
        /// See: https://stackoverflow.com/a/71978849/2805570
        .commands {
            CommandGroup(replacing: .newItem) {
                Button {
                    newDocument(SnapshotDocument())
                } label: {
                    Label("New Snapshot Document", systemImage: "plus")
                }
                .keyboardShortcut("N", modifiers: .command)
                
                Button {
                    newDocument(SnapshotsDocument())
                } label: {
                    Label("New Snapshots Document", systemImage: "plus")
                }
                .keyboardShortcut("N", modifiers: [.shift, .command])
            }
        }
        .commands {
            SidebarCommands()
        }
    }
}
