//
//  AudioProperty.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

public struct AudioProperty<SelectorConstant: AudioPropertySelectorConstant, Qualifier, Value> {
    public typealias Selector = AudioPropertySelector<SelectorConstant, Qualifier, Value>
    public let selector: Selector
    
    public typealias Scope = AudioPropertyScopeConstant
    public let scope: any Scope
    
    public typealias Element = AudioPropertyElementConstant
    public let element: any Element
    
    public init(selector: Selector, scope: any Scope, element: any Element) {
        self.selector = selector
        self.scope = scope
        self.element = element
    }
}

extension AudioProperty: AudioPropertyProtocol { }

// MARK: - CustomStringConvertible

extension AudioProperty: CustomStringConvertible {
    public var description: String {
        "AudioProperty(\(address.description))"
    }
}

// MARK: - CustomDebugStringConvertible

extension AudioProperty: CustomDebugStringConvertible {
    public var debugDescription: String {
        "AudioProperty(\(address.description))"
    }
}

// MARK: - Inits

extension AudioProperty {
    public init(selectorConstant: SelectorConstant, scope: any Scope, element: any Element) {
        self.selector = Selector(constant: selectorConstant)
        self.scope = scope
        self.element = element
    }
}

// MARK: - Properties

extension AudioProperty {
    /// Returns a new Core Audio `AudioObjectPropertyAddress` instance constructed from the property's
    /// selector, scope, and element.
    public var address: AudioObjectPropertyAddress {
        AudioObjectPropertyAddress(selector: selector.constant, scope: scope, element: element)
    }
}

#endif
