//
//  FilterablePropertiesView.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftUI
import SwiftCoreAudio
import UniformTypeIdentifiers

struct FilterablePropertiesView: View {
    let snapshot: AudioObjectSnapshot
    @Binding var searchText: String
    
    @State private var properties: [PropertyItem] = []
    @State private var filteredProperties: [PropertyItem] = []
    @State private var selectedPropertyIDs: Set<PropertyItem.ID> = []
    
    var body: some View {
        VStack {
            if filteredProperties.isEmpty {
                FillerInfoView(
                    systemImage: "text.magnifyingglass",
                    title: searchText.isEmpty ? "No properties to display." : "No property names or values match the search criteria."
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                PropertiesView(properties: filteredProperties, selectedPropertyIDs: $selectedPropertyIDs)
            }
        }
        #if os(macOS)
        .onCopyCommand {
            itemProviders()
        }
        #endif
        .onChange(of: snapshot, initial: true) { _, _ in
            updateProperties()
        }
        .onChange(of: properties) { _, _ in
            updateFilteredProperties()
        }
        .onChange(of: searchText) { _, _ in
            updateFilteredProperties()
        }
    }
    
    private func updateProperties() {
        var properties: [PropertyItem] = []
        properties += snapshot.properties.map {
            PropertyItem(key: $0.key, value: $0.value)
        }
        self.properties = properties.sorted(by: {
            $0.key.localizedCaseInsensitiveCompare($1.key) == .orderedAscending
        })
    }
    
    private func updateFilteredProperties() {
        let newProperties = if searchText.isEmpty {
            properties
        } else {
            properties.filter {
                $0.key.localizedCaseInsensitiveContains(searchText)
                    || $0.value.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        filteredProperties = newProperties
    }
    
    private func itemProviders() -> [NSItemProvider] {
        guard !selectedPropertyIDs.isEmpty else { return [] }
        
        func string(for property: PropertyItem) -> String {
            selectedPropertyIDs.count == 1
                ? property.value
                : "\(property.id): \(property.value)"
        }
        
        let text = properties
            .filter { selectedPropertyIDs.contains($0.id) } // maintain property order
            .map { string(for: $0) }
            .joined(separator: "\n")
        
        let provider = NSItemProvider(object: text as NSString)
        return [provider]
    }
}

#Preview("Empty") {
    FilterablePropertiesView(snapshot: AudioObjectSnapshot(objectID: 0), searchText: .constant(""))
}

#Preview("BlackHole") {
    FilterablePropertiesView(snapshot: AudioObjectSnapshot(of: try! AudioDevice(uid: .init("BlackHole2ch_UID"))!), searchText: .constant(""))
}
