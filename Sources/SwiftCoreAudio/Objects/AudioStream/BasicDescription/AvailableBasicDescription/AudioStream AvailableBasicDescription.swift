//
//  AudioStream AvailableBasicDescription.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

extension AudioStream {
    /// Basic description used when querying Core Audio for multiple available stream descriptions.
    ///
    /// Not used for querying the single, current stream description.
    public typealias AvailableBasicDescription = BasicDescription<AvailableSampleRate>
}

#endif
