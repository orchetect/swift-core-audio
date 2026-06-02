//
//  AudioProperty+Object.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

// MARK: Scope & Element

extension AudioProperty where SelectorConstant == AudioObjectPropertySelectorConstant {
    nonisolated
    private static var scope: any AudioPropertyScopeConstant { .object(.global) }
    
    nonisolated
    private static var element: any AudioPropertyElementConstant { .object(.main) }
}

// MARK: - CoreAudio/AudioHardwareBase.h

extension AudioProperty where SelectorConstant == AudioObjectPropertySelectorConstant, Qualifier == Never, Value == AudioObjectID {
    nonisolated
    public static var baseClassID: Self {
        AudioProperty(selectorConstant: .baseClass, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioObjectPropertySelectorConstant, Qualifier == Never, Value == AudioObjectID {
    nonisolated
    public static var classID: Self {
        AudioProperty(selectorConstant: .class, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioObjectPropertySelectorConstant, Qualifier == Never, Value == AudioObjectID {
    nonisolated
    public static var owner: Self {
        AudioProperty(selectorConstant: .owner, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioObjectPropertySelectorConstant, Qualifier == Never, Value == String {
    nonisolated
    public static var name: Self {
        AudioProperty(selectorConstant: .name, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioObjectPropertySelectorConstant, Qualifier == Never, Value == String {
    nonisolated
    public static var modelName: Self {
        AudioProperty(selectorConstant: .modelName, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioObjectPropertySelectorConstant, Qualifier == Never, Value == String {
    nonisolated
    public static var manufacturer: Self {
        AudioProperty(selectorConstant: .manufacturer, scope: scope, element: element)
    }
}

// `elementName` is implemented directly on object subclasses for properties that use it

// `elementCategoryName` is implemented directly on object subclasses for properties that use it

// `elementNumberName` is implemented directly on object subclasses for properties that use it

extension AudioProperty where SelectorConstant == AudioObjectPropertySelectorConstant, Qualifier == [AudioClassID], Value == [AudioObjectID] {
    nonisolated
    public static var ownedObjects: Self {
        AudioProperty(selectorConstant: .ownedObjects, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioObjectPropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static var identify: Self {
        AudioProperty(selectorConstant: .identify, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioObjectPropertySelectorConstant, Qualifier == Never, Value == String {
    nonisolated
    public static var serialNumber: Self {
        AudioProperty(selectorConstant: .serialNumber, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioObjectPropertySelectorConstant, Qualifier == Never, Value == String {
    nonisolated
    public static var firmwareVersion: Self {
        AudioProperty(selectorConstant: .firmwareVersion, scope: scope, element: element)
    }
}

// MARK: - CoreAudio/AudioHardware.h

extension AudioProperty where SelectorConstant == AudioObjectPropertySelectorConstant, Qualifier == Never, Value == String {
    nonisolated
    public static var creator: Self {
        AudioProperty(selectorConstant: .creator, scope: scope, element: element)
    }
}

#endif
