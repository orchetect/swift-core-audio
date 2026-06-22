//
//  AudioPropertySelector.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

/// Selector constant with strongly-typed qualifier and value types provided to a Core Audio object property method.
public struct AudioPropertySelector<
    Constant: AudioPropertySelectorConstant,
    Qualifier,
    Value
>: Equatable, Hashable, Sendable {
    public let constant: Constant

    /// Internal init.
    init(constant: Constant) {
        self.constant = constant
    }
}

#endif
