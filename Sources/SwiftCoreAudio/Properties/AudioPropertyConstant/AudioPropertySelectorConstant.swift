//
//  AudioPropertySelectorConstant.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

/// Core Audio property selector constants.
///
/// `AudioObjectPropertySelector` values.
///
/// An `AudioObjectPropertySelector` is a four char code that identifies, along with
/// the `AudioObjectPropertyScope` and `AudioObjectPropertyElement`, a specific piece of
/// information about an `AudioObject`.
///
/// The property selector specifies the general classification of the property such
/// as volume, stream format, latency, etc. Note that each class has a different set
/// of selectors. A subclass inherits its super class's set of selectors, although
/// it may not implement them all.
public protocol AudioPropertySelectorConstant: AudioPropertyConstant { }

#endif
