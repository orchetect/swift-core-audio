//
//  AudioTapProperties+Property.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

// MARK: - Property Selector Type

extension AudioTapProperties {
    public typealias TapSelectorConstant = AudioTapPropertySelectorConstant
    public typealias TapProperty<Qualifier, Value> = AudioProperty<TapSelectorConstant, Qualifier, Value>
}

#endif
