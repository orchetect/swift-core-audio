//
//  AudioSelectorControlPropertySelectorConstant.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

/// Analogous to CoreAudio `kAudioSelectorControlProperty*` selector constants.
///
/// `AudioObjectPropertySelector` values provided by the `AudioSelectorControl` class.
public enum AudioSelectorControlPropertySelectorConstant {
    // MARK: CoreAudio/AudioHardwareBase.h
    
    /// Current Item
    ///
    /// An array of `UInt32`s that are the IDs of the items currently selected.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioSelectorControlPropertyCurrentItem`
    case currentItem
    
    /// Available Items
    ///
    /// An array of `UInt32`s that represent the IDs of all the items available.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioSelectorControlPropertyAvailableItems`
    case availableItems
    
    /// Item Name
    ///
    /// This property translates the given item ID into a human readable name. The
    /// qualifier contains the ID of the item to be translated and name is returned
    /// as a `CFString` as the property data.
    ///
    /// The caller is responsible for releasing the returned `CFObject`.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioSelectorControlPropertyItemName`
    case itemName
    
    /// Item Kind
    ///
    /// This property returns a `UInt32` that identifies the kind of selector item the
    /// item ID refers to.
    ///
    /// The qualifier contains the ID of the item.
    ///
    /// Note that this property is optional for selector controls and that the meaning of the
    /// value depends on the specific subclass being queried.
    ///
    /// > File: CoreAudio/AudioHardwareBase.h
    ///
    /// > Constant: `kAudioSelectorControlPropertyItemKind`
    case itemKind
}

extension AudioSelectorControlPropertySelectorConstant: AudioPropertySelectorConstant { }

extension AudioSelectorControlPropertySelectorConstant: Equatable { }

extension AudioSelectorControlPropertySelectorConstant: Hashable { }

extension AudioSelectorControlPropertySelectorConstant: CaseIterable { }

extension AudioSelectorControlPropertySelectorConstant: Sendable { }

// MARK: - Inits

extension AudioSelectorControlPropertySelectorConstant {
    /// Same as ``init(rawValue:)`` but throws an error instead of returning `nil` when a match is not found.
    nonisolated
    public init(tryingRawValue rawValue: FourCharCode) throws(SwiftCoreAudioError) { // a.k.a. UInt32
        guard let match = Self(rawValue: rawValue) else {
            throw .notYetImplemented(
                message: "Unhandled/unrecognized audio selector control property selector constant value: \(rawValue)"
            )
        }
        self = match
    }
}

// MARK: - RawRepresentable

extension AudioSelectorControlPropertySelectorConstant: RawRepresentable {
    nonisolated
    public init?(rawValue: FourCharCode) { // a.k.a. UInt32
        guard let match = Self.allCases
            .first(where: { $0.rawValue == rawValue })
        else {
            return nil
        }
        self = match
    }
    
    nonisolated
    public var rawValue: FourCharCode { // a.k.a. UInt32
        switch self {
        // MARK: CoreAudio/AudioHardwareBase.h
        case .currentItem: kAudioSelectorControlPropertyCurrentItem // "scci"
        case .availableItems: kAudioSelectorControlPropertyAvailableItems // "scai"
        case .itemName: kAudioSelectorControlPropertyItemName // "scin"
        case .itemKind: kAudioSelectorControlPropertyItemKind // "clkk"
        }
    }
}

extension AudioSelectorControlPropertySelectorConstant: CustomStringConvertible {
    nonisolated
    public var description: String {
        switch self {
        // MARK: CoreAudio/AudioHardwareBase.h
        case .currentItem: "Current Item"
        case .availableItems: "Available Items"
        case .itemName: "Item Name"
        case .itemKind: "Item Kind"
        }
    }
}

// MARK: - Static Constructors

extension AudioPropertySelectorConstant where Self == AudioSelectorControlPropertySelectorConstant {
    /// Analogous to CoreAudio `kAudioSelectorControlProperty*` selector constants.
    ///
    /// `AudioObjectPropertySelector` values provided by the `AudioSelectorControl` class.
    public static func selectorControl(_ selector: Self) -> Self {
        selector
    }
}

#endif
