//
//  AudioProperty+Process.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

// swiftformat:disable wrap wrapArguments
// swiftformat:options --wrap-collections preserve

// MARK: Scope & Element

extension AudioProperty where SelectorConstant == AudioProcessPropertySelectorConstant {
    nonisolated
    private static var defaultScope: any AudioPropertyScopeConstant {
        .object(.global)
    }

    nonisolated
    private static func scope(for direction: AudioStream.Direction?) -> any AudioPropertyScopeConstant {
        switch direction {
        case .input: .object(.input)
        case .output: .object(.output)
        case nil: .object(.global) // TODO: I assume this works, needs testing
        }
    }

    nonisolated
    private static var element: any AudioPropertyElementConstant {
        .object(.main)
    }
}

// MARK: - CoreAudio/AudioHardware.h

extension AudioProperty where SelectorConstant == AudioProcessPropertySelectorConstant, Qualifier == Never, Value == pid_t {
    nonisolated
    public static var pid: Self {
        AudioProperty(selectorConstant: .pid, scope: defaultScope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioProcessPropertySelectorConstant, Qualifier == Never, Value == String {
    nonisolated
    public static var bundleID: Self {
        AudioProperty(selectorConstant: .bundleID, scope: defaultScope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioProcessPropertySelectorConstant, Qualifier == Never, Value == [AudioObjectID] {
    nonisolated
    public static func devices(for direction: AudioStream.Direction?) -> Self {
        AudioProperty(selectorConstant: .devices, scope: scope(for: direction), element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioProcessPropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static var isRunning: Self {
        AudioProperty(selectorConstant: .isRunning, scope: defaultScope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioProcessPropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static var isRunningInput: Self {
        AudioProperty(selectorConstant: .isRunningInput, scope: defaultScope, element: element)
    }
}

extension AudioProperty where SelectorConstant == AudioProcessPropertySelectorConstant, Qualifier == Never, Value == Bool {
    nonisolated
    public static var isRunningOutput: Self {
        AudioProperty(selectorConstant: .isRunningOutput, scope: defaultScope, element: element)
    }
}

#endif
