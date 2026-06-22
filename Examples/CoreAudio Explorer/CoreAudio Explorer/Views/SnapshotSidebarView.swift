//
//  SnapshotSidebarView.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftCoreAudio
import SwiftUI

struct SnapshotSidebarView: View {
    @Bindable var model: SnapshotModel

    @State private var categories: [Category] = []
    @State private var filteredCategories: [Category] = []

    var body: some View {
        List(selection: $model.selectedIDs) {
            if let snapshot = model.snapshot, !snapshot.isEmpty {
                NavigationLink(value: snapshot) {
                    Label(model.name(for: snapshot) ?? "Untitled Object", systemImage: "hifispeaker")
                }
                .tag(snapshot.id)
            }

            ForEach(filteredCategories) { category in
                CategoryView(model: model, category: category)
            }
        }
        .onChange(of: model.snapshot?.children, initial: true) { oldValue, newValue in
            updateCategories()
        }
        .onChange(of: categories) { _, _ in
            updateFilteredCategories()
        }
        .onChange(of: model.sidebarSearchText) { _, _ in
            updateFilteredCategories()
        }
    }

    private func updateCategories() {
        guard let snapshot = model.snapshot else {
            categories = []
            return
        }
        categories = snapshot.children.reduce(into: []) { array, child in
            let childClassIDString = child.properties[.object(.classID)]
                ?? child.properties[.object(.baseClassID)]

            let childClassID: AudioObjectClassID = if let childClassIDString,
                                                      let childClassIDInt = UInt32(childClassIDString),
                                                      let childClassID = AudioObjectClassID(rawValue: childClassIDInt)
            {
                childClassID
            } else {
                .wildcard
            }

            let categoryIndex: Int
            if let index = array.firstIndex(where: { $0.classID == childClassID }) {
                categoryIndex = index
            } else {
                let newCategory = Category(classID: childClassID)
                array.append(newCategory)
                categoryIndex = array.indices.last!
            }

            array[categoryIndex].snapshots.append(child)
        }
    }

    private func updateFilteredCategories() {
        let newCategories = if model.sidebarSearchText.isEmpty {
            categories
        } else {
            categories.compactMap { category -> Category? in
                // if the category name matches, return the entire category with all of its contents
                if category.name.localizedCaseInsensitiveContains(model.sidebarSearchText) { return category }

                // otherwise, filter contents of category
                let filteredSnapshots = category.snapshots.filter { snapshot in
                    let sources: [String] = [
                        model.name(for: snapshot),
                        snapshot.objectID.description
                    ].compactMap(\.self)

                    return sources.contains {
                        $0.localizedCaseInsensitiveContains(model.sidebarSearchText) == true
                    }
                }

                if !filteredSnapshots.isEmpty {
                    var newCategory = category
                    newCategory.snapshots = filteredSnapshots
                    return newCategory
                } else {
                    return nil
                }
            }
        }

        filteredCategories = newCategories
    }
}
