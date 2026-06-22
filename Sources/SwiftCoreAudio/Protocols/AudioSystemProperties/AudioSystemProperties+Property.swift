//
//  AudioSystemProperties+Property.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

// MARK: - Property Selector Type

extension AudioSystemProperties {
    public typealias SystemSelectorConstant = AudioSystemPropertySelectorConstant
    public typealias SystemProperty<Qualifier, Value> = AudioProperty<SystemSelectorConstant, Qualifier, Value>
}

#endif
