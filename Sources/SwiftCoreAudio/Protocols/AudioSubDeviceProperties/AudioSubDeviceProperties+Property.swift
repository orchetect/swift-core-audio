//
//  AudioSubDeviceProperties+Property.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

// MARK: - Property Selector Type

extension AudioSubDeviceProperties {
    public typealias SubDeviceSelectorConstant = AudioSubDevicePropertySelectorConstant
    public typealias SubDeviceProperty<Qualifier, Value> = AudioProperty<SubDeviceSelectorConstant, Qualifier, Value>
}

#endif
