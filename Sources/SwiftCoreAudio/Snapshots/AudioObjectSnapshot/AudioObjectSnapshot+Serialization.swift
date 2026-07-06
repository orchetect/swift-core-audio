//
//  AudioObjectSnapshot+Serialization.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreTransferable
import Foundation

extension AudioObjectSnapshot {
    /// Decodes the raw JSON data content of a `.coreaudiosnapshot` file.
    public init(data: Data) throws{
        let decoder = JSONDecoder()
        self = try decoder.decode(Self.self, from: data)
    }

    /// Encodes the snapshot as raw JSON data suitable for saving as a `.coreaudiosnapshot` file.
    public func data() throws -> Data {
        let encoder = JSONEncoder()
        let encodedFileData = try encoder.encode(self)
        return encodedFileData
    }
}

#endif
