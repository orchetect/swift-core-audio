//
//  AudioDeviceProperties+Property.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

// MARK: - Property Selector Type

extension AudioDeviceProperties {
    public typealias DeviceSelectorConstant = AudioDevicePropertySelectorConstant
    public typealias DeviceProperty<Qualifier, Value> = AudioProperty<DeviceSelectorConstant, Qualifier, Value>
}

#endif
