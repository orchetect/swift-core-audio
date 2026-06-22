//
//  AudioSubDevice+AudioDeviceProperties.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

// TODO: AudioSubDevice is a subclass of AudioDevice, however some of AudioDevice's properties are not applicable
extension AudioSubDevice: AudioDeviceProperties { }

#endif
