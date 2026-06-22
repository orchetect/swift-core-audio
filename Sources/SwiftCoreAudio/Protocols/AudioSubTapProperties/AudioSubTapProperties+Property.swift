//
//  AudioSubTapProperties+Property.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

// MARK: - Property Selector Type

extension AudioSubTapProperties {
    public typealias SubTapSelectorConstant = AudioSubTapPropertySelectorConstant
    public typealias SubTapProperty<Qualifier, Value> = AudioProperty<SubTapSelectorConstant, Qualifier, Value>
}

#endif
