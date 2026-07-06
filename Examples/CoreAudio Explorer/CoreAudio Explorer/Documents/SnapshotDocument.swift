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

        snapshot = try AudioObjectSnapshot(data: data)
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = try snapshot.data()
        return .init(regularFileWithContents: data)
    }
}
