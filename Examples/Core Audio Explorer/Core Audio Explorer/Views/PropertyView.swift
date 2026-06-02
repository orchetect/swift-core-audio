//
//  PropertyView.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftUI
import SwiftCoreAudio

struct PropertyView: View {
    let propertyItem: PropertyItem
    
    var body: some View {
        LabeledContent(propertyItem.key, value: propertyItem.value)
    }
}

extension PropertyView: Identifiable {
    var id: String { propertyItem.id }
}
