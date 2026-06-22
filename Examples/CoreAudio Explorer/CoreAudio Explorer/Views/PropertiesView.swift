//
//  PropertiesView.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftUI

struct PropertiesView: View {
    let properties: [PropertyItem]
    @Binding var selectedPropertyIDs: Set<PropertyItem.ID>

    var body: some View {
        List(selection: $selectedPropertyIDs) {
            ForEach(properties) { property in
                PropertyView(propertyItem: property)
            }
        }
    }
}
