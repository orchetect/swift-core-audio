//
//  AudioTapProperties+Implementation.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio
import SwiftProcess

extension AudioTapProperties {
    // MARK: CoreAudio/AudioHardware.h
    
    nonisolated
    public var tapUID: UID {
        get throws(SwiftCoreAudioError) {
            let string = try getPropertyValue(property: TapProperty.uid)
            return UID(rawValue: string)
        }
    }
    
    @available(macOS 12.0, macCatalyst 15.0, *)
    nonisolated
    public var tapDescription: CATapDescription {
        get throws(SwiftCoreAudioError) {
            try getPropertyObject(address: TapProperty.description.address, qualifier: .none)
        }
    }
    
    @available(macOS 12.0, macCatalyst 15.0, *)
    nonisolated
    public func setTapDescription(_ tapDescription: CATapDescription) throws(SwiftCoreAudioError) {
        try setPropertyObject(address: TapProperty.description.address, qualifier: .none, object: tapDescription)
    }
    
    nonisolated
    public var format: AudioStream.CurrentBasicDescription {
        get throws(SwiftCoreAudioError) {
            let rawDesc = try getPropertyValue(property: TapProperty.format)
            // TODO: not sure if this is always a "current" or "available" basic description. I assume it's current.
            let basicDesc = try AudioStream.CurrentBasicDescription(from: rawDesc)
            return basicDesc
        }
    }
}

#endif
