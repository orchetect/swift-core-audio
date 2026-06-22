//
//  AudioAggregateDeviceProperties+Property.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

// MARK: - Property Selector Type

extension AudioAggregateDeviceProperties {
    public typealias AggregateDeviceSelectorConstant = AudioAggregateDevicePropertySelectorConstant
    public typealias AggregateDeviceProperty<Qualifier, Value> = AudioProperty<AggregateDeviceSelectorConstant, Qualifier, Value>
}

#endif
