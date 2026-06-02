//
//  AudioProcessProperties+Property.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

// MARK: - Property Selector Type

extension AudioProcessProperties {
    public typealias ProcessSelectorConstant = AudioProcessPropertySelectorConstant
    public typealias ProcessProperty<Qualifier, Value> = AudioProperty<ProcessSelectorConstant, Qualifier, Value>
}

#endif
