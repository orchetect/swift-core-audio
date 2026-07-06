//
//  AudioObjectSnapshot+Serialization.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreTransferable
import Foundation

extension AudioObjectSnapshot {
    /// Decodes the raw JSON data content of the publicly-imported ``UniformTypeIdentifiers/UTType/coreAudioSnapshot``
    /// data type which comprises the data content of a `coreaudiosnapshot` file readable by the CoreAudio Explorer
    /// app bundled with SwiftCoreAudio.
    public init(data: Data) throws{
        let decoder = JSONDecoder()
        self = try decoder.decode(Self.self, from: data)
    }

    /// Encodes the raw JSON data content of the publicly-imported ``UniformTypeIdentifiers/UTType/coreAudioSnapshot``
    /// data type which comprises the data content of a `coreaudiosnapshot` file readable by the CoreAudio Explorer
    /// app bundled with SwiftCoreAudio.
    public func data() throws -> Data {
        let encoder = JSONEncoder()
        let encodedFileData = try encoder.encode(self)
        return encodedFileData
    }
}

#endif
