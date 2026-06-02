//
//  AudioClockProperties+Property.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

// MARK: - Property Selector Type

extension AudioClockProperties {
    public typealias ClockSelectorConstant = AudioClockPropertySelectorConstant
    public typealias ClockProperty<Qualifier, Value> = AudioProperty<ClockSelectorConstant, Qualifier, Value>
}

#endif
