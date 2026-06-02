//
//  AudioBoxProperties+Property.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

// MARK: - Property Selector Type

extension AudioBoxProperties {
    public typealias BoxSelectorConstant = AudioBoxPropertySelectorConstant
    public typealias BoxProperty<Qualifier, Value> = AudioProperty<BoxSelectorConstant, Qualifier, Value>
}

#endif
