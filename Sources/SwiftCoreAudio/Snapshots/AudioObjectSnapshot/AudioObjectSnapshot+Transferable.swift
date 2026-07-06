//
//  AudioObjectSnapshot+Transferable.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreTransferable
import Foundation

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
extension AudioObjectSnapshot: Transferable {
    public static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(contentType: .coreAudioSnapshot) { snapshot in
            try snapshot.data()
        } importing: { data in
            try AudioObjectSnapshot(data: data)
        }
        DataRepresentation(exportedContentType: .coreAudioSnapshot) { snapshot in
            try snapshot.data()
        }
    }
}

#endif
