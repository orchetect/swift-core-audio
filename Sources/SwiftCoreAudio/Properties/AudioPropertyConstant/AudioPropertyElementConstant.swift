//
//  AudioPropertyElementConstant.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

/// Core Audio property element constants.
///
/// `AudioObjectPropertyElement` values.
///
/// An `AudioObjectPropertyElement` is an integer that identifies, along with the
/// `AudioObjectPropertySelector` and `AudioObjectPropertyScope`, a specific piece of
/// information about an `AudioObject`.
///
/// The element selects one of possibly many items in the section of the object in
/// which to look for the property. Elements are number sequentially where `0`
/// represents the main element. Elements are particular to an instance of a
/// class, meaning that two instances can have different numbers of elements in the
/// same scope. There is no inheritance of elements.
public protocol AudioPropertyElementConstant: AudioPropertyConstant { }

#endif
