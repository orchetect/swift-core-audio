//
//  PropertyItem.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftUI
import SwiftCoreAudio

struct PropertyItem {
    let key: String
    let value: String
    
    init(key: some AudioObjectSnapshot.PropertyKey, value: String) {
        self.key = key.rawValue
        self.value = value
    }
}

extension PropertyItem: Equatable { }

extension PropertyItem: Hashable { }

extension PropertyItem: Sendable { }

extension PropertyItem: Identifiable {
    var id: String { key }
}
