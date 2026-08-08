//
//  Static Metadata.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

/// Standard built-in microphone audio device on Mac computers.
/// The same common UID is used across systems -- see AudioDevice.UID+Static.swift
enum BuiltInMic {
    /// Known built-in speaker audio device display names.
    static let names: [String] = [
        "MacBook Pro Microphone" // 2021 M1 Max MacBook Pro
    ]
}

/// Standard built-in speakers audio device on Mac computers.
/// The same common UID is used across systems -- see AudioDevice.UID+Static.swift
enum BuiltInSpeakers {
    /// Known built-in speaker audio device display names.
    static let names: [String] = [
        "MacBook Pro Speakers", // 2021 M1 Max MacBook Pro
        "Mac Pro Speakers", // 2019 16-core Mac Pro
        "Mac mini Speakers" // M4 Mac Mini
    ]
}

/// Standard built-in audio device in macOS virtual machines.
enum VMAudioDevice {
    static let name = "Apple Virtual Sound Device" // macOS 27 VM
}

#endif
