//
//  AudioStreamProperties+Property.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

// MARK: - Property Selector Type

extension AudioStreamProperties {
    public typealias StreamSelectorConstant = AudioStreamPropertySelectorConstant
    public typealias StreamProperty<Qualifier, Value> = AudioProperty<StreamSelectorConstant, Qualifier, Value>
}

#endif
