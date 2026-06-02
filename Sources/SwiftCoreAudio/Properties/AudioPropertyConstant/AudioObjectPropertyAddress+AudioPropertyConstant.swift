//
//  AudioObjectPropertyAddress+AudioPropertyConstant.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

extension AudioObjectPropertyAddress {
    /// Initialize from strongly-typed selector, scope, and element enumerations.
    public init(
        selector: any AudioPropertySelectorConstant,
        scope: any AudioPropertyScopeConstant,
        element: any AudioPropertyElementConstant
    ) {
        self.init(mSelector: selector.rawValue, mScope: scope.rawValue, mElement: element.rawValue)
    }
}

#endif
