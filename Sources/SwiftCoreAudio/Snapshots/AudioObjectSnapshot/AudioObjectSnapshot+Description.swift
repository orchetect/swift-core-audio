//
//  AudioObjectSnapshot+Description.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

extension AudioObjectSnapshot: CustomStringConvertible {
    public var description: String {
        "AudioObjectSnapshot(\(objectID))"
    }
}

extension AudioObjectSnapshot: CustomDebugStringConvertible {
    public var debugDescription: String {
        description
    }
}

extension AudioObjectSnapshot {
    /// Returns a human-readable output suitable for logging or debugging.
    public var prettyDescription: String {
        var output = ""

        // AudioObject
        output += "id: \(id)\n"

        // iterate over all property keys so that ordering remains stable to the enum ordering
        for key in AnyPropertyKey.allCases {
            if let value = properties[key] {
                output += "\(key): \(value)\n"
            }
        }

        // iterate over children
        for child in children {
            output += child.prettyDescription
        }

        return output
            .trimmingCharacters(in: .newlines)
    }
}

#endif
