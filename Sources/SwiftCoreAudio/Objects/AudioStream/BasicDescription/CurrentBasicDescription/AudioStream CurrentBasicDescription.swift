//
//  AudioStream CurrentBasicDescription.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

extension AudioStream {
    /// Basic description used when querying Core Audio for a single, current stream description.
    ///
    /// Not used for querying Core Audio for multiple available stream descriptions.
    public typealias CurrentBasicDescription = BasicDescription<Double>
}

#endif
