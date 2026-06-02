//
//  AudioStream Direction+AudioHardware.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

// MARK: - AudioHardwareDirection

extension AudioStream.Direction {
    /// Construct from a Core Audio `AudioHardwareDirection` instance.
    @available(macOS 15.0, *)
    nonisolated
    public init(audioHardwareDirection: AudioHardwareDirection) {
        self = switch audioHardwareDirection {
        case .input: .input
        case .output: .output
        @unknown default:
            fatalError("Unhandled AudioHardwareDirection raw value: \(audioHardwareDirection.rawValue)")
        }
    }
    
    /// Returns the Core Audio `AudioHardwareDirection` instance that corresponds to `self`.
    @available(macOS 15.0, *)
    nonisolated
    public var audioHardwareDirection: AudioHardwareDirection {
        switch self {
        case .input: .input
        case .output: .output
        }
    }
}

#endif
