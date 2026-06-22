//
//  AudioPropertyScopeConstant.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

/// Core Audio property scope constants.
///
/// `AudioObjectPropertyScope` values.
///
/// An `AudioObjectPropertyScope` is a four char code that identifies, along with the
/// `AudioObjectPropertySelector` and `AudioObjectPropertyElement`, a specific piece of
/// information about an `AudioObject`.
///
/// The scope specifies the section of the object in which to look for the property,
/// such as input, output, global, etc. Note that each class has a different set of
/// scopes. A subclass inherits its superclass's set of scopes.
public protocol AudioPropertyScopeConstant: AudioPropertyConstant { }

#endif
