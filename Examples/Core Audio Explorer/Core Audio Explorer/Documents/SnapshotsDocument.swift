//
//  SnapshotsDocument.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftCoreAudio
import SwiftUI
import UniformTypeIdentifiers

nonisolated
struct SnapshotsDocument: FileDocument {
    var snapshots: [AudioObjectSnapshot]

    init(snapshots: [AudioObjectSnapshot]? = nil) {
        self.snapshots = snapshots ?? []
    }

    static let readableContentTypes: [UTType] = [
        .coreAudioSnapshots
    ]

    static let writableContentTypes: [UTType] = [
        .coreAudioSnapshots
    ]
    
    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents else {
            throw CocoaError(.fileReadCorruptFile)
        }
        
        let jsonDecoder = JSONDecoder()
        snapshots = try jsonDecoder.decode([AudioObjectSnapshot].self, from: data)
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let jsonEncoder = JSONEncoder()
        let data = try jsonEncoder.encode(snapshots)
        return .init(regularFileWithContents: data)
    }
}

extension UTType {
    nonisolated
    static let coreAudioSnapshots = UTType(importedAs: "com.orchetect.SwiftCoreAudio.Snapshots")
}
