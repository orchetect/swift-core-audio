//
//  AudioProperty+TransportManager.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

// MARK: Scope & Element

extension AudioProperty where SelectorConstant == AudioTransportManagerPropertySelectorConstant {
    nonisolated
    private static var scope: any AudioPropertyScopeConstant { .object(.global) }
    
    nonisolated
    private static var element: any AudioPropertyElementConstant { .object(.main) }
}

// MARK: CoreAudio/AudioHardwareBase.h

extension AudioProperty where SelectorConstant == AudioTransportManagerPropertySelectorConstant, Qualifier == Never, Value == [AudioObjectID] {
    nonisolated
    public static var endPointList: Self {
        AudioProperty(selectorConstant: .endPointList, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioTransportManagerPropertySelectorConstant, Qualifier == String, Value == AudioObjectID {
    nonisolated
    public static var translateUIDToEndPoint: Self {
        AudioProperty(selectorConstant: .translateUIDToEndPoint, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioTransportManagerPropertySelectorConstant, Qualifier == Never, Value == UInt32 {
    nonisolated
    public static var transportType: Self {
        AudioProperty(selectorConstant: .transportType, scope: scope, element: element)
    }
}

// MARK: CoreAudio/AudioHardware.h

extension AudioProperty where SelectorConstant == AudioTransportManagerPropertySelectorConstant, Qualifier == CFDictionary, Value == AudioObjectID {
    nonisolated
    public static var createEndPointDevice: Self {
        AudioProperty(selectorConstant: .createEndPointDevice, scope: scope, element: element)
    }
}

// TODO: not sure what this returns
extension AudioProperty where SelectorConstant == AudioTransportManagerPropertySelectorConstant, Qualifier == AudioObjectID, Value == Never {
    nonisolated
    public static var destroyEndPointDevice: Self {
        AudioProperty(selectorConstant: .destroyEndPointDevice, scope: scope, element: element)
    }
}

#endif
