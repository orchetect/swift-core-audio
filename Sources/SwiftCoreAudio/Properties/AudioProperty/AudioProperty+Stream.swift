//
//  AudioProperty+Stream.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

// MARK: Scope & Element

extension AudioProperty where SelectorConstant == AudioStreamPropertySelectorConstant {
    /// Has only the single scope, `kAudioObjectPropertyScopeGlobal`.
    nonisolated
    private static var scope: any AudioPropertyScopeConstant { .object(.global) }
    
    /// Has a main element, and an element for each channel in the stream numbered upward from `1`.
    nonisolated
    private static var element: any AudioPropertyElementConstant { .object(.main) }
}

// MARK: CoreAudio/AudioHardware.h

extension AudioProperty where SelectorConstant == AudioStreamPropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static var isActive: Self {
        AudioProperty(selectorConstant: .isActive, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioStreamPropertySelectorConstant, Qualifier == Never, Value == UInt32 {
    nonisolated
    public static var direction: Self {
        AudioProperty(selectorConstant: .direction, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioStreamPropertySelectorConstant, Qualifier == Never, Value == UInt32 {
    nonisolated
    public static var terminalType: Self {
        AudioProperty(selectorConstant: .terminalType, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioStreamPropertySelectorConstant, Qualifier == Never, Value == UInt32 {
    nonisolated
    public static var startingChannel: Self {
        AudioProperty(selectorConstant: .startingChannel, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioStreamPropertySelectorConstant, Qualifier == Never, Value == UInt32 {
    nonisolated
    public static var latency: Self {
        AudioProperty(selectorConstant: .latency, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioStreamPropertySelectorConstant, Qualifier == Never, Value == AudioStreamBasicDescription {
    nonisolated
    public static var virtualFormat: Self {
        AudioProperty(selectorConstant: .virtualFormat, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioStreamPropertySelectorConstant, Qualifier == Never, Value == [AudioStreamRangedDescription] {
    nonisolated
    public static var availableVirtualFormats: Self {
        AudioProperty(selectorConstant: .availableVirtualFormats, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioStreamPropertySelectorConstant, Qualifier == Never, Value == AudioStreamBasicDescription {
    nonisolated
    public static var physicalFormat: Self {
        AudioProperty(selectorConstant: .physicalFormat, scope: scope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioStreamPropertySelectorConstant, Qualifier == Never, Value == [AudioStreamRangedDescription] {
    nonisolated
    public static var availablePhysicalFormats: Self {
        AudioProperty(selectorConstant: .availablePhysicalFormats, scope: scope, element: element)
    }
}

#endif
