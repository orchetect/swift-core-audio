//
//  SnapshotDocument.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftCoreAudio
import SwiftUI
import UniformTypeIdentifiers

nonisolated
struct SnapshotDocument: FileDocument {
    var snapshot: AudioObjectSnapshot

    init(snapshot: AudioObjectSnapshot? = nil) {
        self.snapshot = snapshot ?? AudioObjectSnapshot(objectID: 0)
    }

    static let readableContentTypes: [UTType] = [
        .coreAudioSnapshot
    ]

    static let writableContentTypes: [UTType] = [
        .coreAudioSnapshot
    ]

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents else {
            throw CocoaError(.fileReadCorruptFile)
        }

        let jsonDecoder = JSONDecoder()
        snapshot = try jsonDecoder.decode(AudioObjectSnapshot.self, from: data)
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let jsonEncoder = JSONEncoder()
        let data = try jsonEncoder.encode(snapshot)
        return .init(regularFileWithContents: data)
    }
}

extension UTType {
    nonisolated
    static let coreAudioSnapshot = UTType(importedAs: "com.orchetect.SwiftCoreAudio.Snapshot")
}
