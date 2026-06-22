//
//  SnapshotSidebarView CategoryView.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftCoreAudio
import SwiftUI

extension SnapshotSidebarView {
    struct CategoryView: View {
        @Bindable var model: SnapshotModel
        let category: Category

        @State private var isExpanded: Bool = true

        var body: some View {
            Section(category.name, isExpanded: $isExpanded) {
                ForEach(category.snapshots) { child in
                    NavigationLink(value: child) {
                        label(for: child)
                    }
                    .tag(child.id)
                }
            }
        }

        private func label(for snapshot: AudioObjectSnapshot) -> some View {
            Label(
                model.name(for: snapshot) ?? "Unknown Object",
                systemImage: model.imageName(for: snapshot) ?? "questionmark.square.dashed"
            )
            .badge(snapshot.objectID)
            .badgeProminence(.standard)
        }
    }
}
