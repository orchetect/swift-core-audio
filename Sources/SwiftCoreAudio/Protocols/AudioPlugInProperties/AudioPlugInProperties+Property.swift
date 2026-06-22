//
//  AudioPlugInProperties+Property.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

// MARK: - Property Selector Type

extension AudioPlugInProperties {
    public typealias PlugInSelectorConstant = AudioPlugInPropertySelectorConstant
    public typealias PlugInProperty<Qualifier, Value> = AudioProperty<PlugInSelectorConstant, Qualifier, Value>
}

#endif
