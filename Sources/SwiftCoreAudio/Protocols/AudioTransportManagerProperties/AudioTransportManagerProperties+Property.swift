//
//  AudioTransportManagerProperties+Property.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

// MARK: - Property Selector Type

extension AudioTransportManagerProperties {
    public typealias TransportManagerSelectorConstant = AudioTransportManagerPropertySelectorConstant
    public typealias TransportManagerProperty<Qualifier, Value> = AudioProperty<TransportManagerSelectorConstant, Qualifier, Value>
}

#endif
