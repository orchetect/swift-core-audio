//
//  AudioObjectProperties+Property.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

// MARK: - Property Selector Type

extension AudioObjectProperties {
    public typealias ObjectSelectorConstant = AudioObjectPropertySelectorConstant
    public typealias ObjectProperty<Qualifier, Value> = AudioProperty<ObjectSelectorConstant, Qualifier, Value>
}

#endif
