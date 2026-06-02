//
//  SwiftCoreAudioError.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import CoreAudio
import Foundation
import SwiftProcess

/// Errors thrown by SwiftCoreAudio methods.
public enum SwiftCoreAudioError {
    /// An aggregate audio device with the given UID already exists in the system.
//    case aggregateAlreadyExists(uid: AudioAggregateDevice.UID)

    /// Aggregate audio device creation timeout.
    case aggregateCreationTimeout
    
    /// Aggregate audio device creation failed.
    case aggregateCreationFailed(message: String? = nil)

    /// Aggregate audio device destruction timeout.
    case aggregateDestructionTimeout

    /// Core Audio AudioBox not found.
    case audioBoxNotFound

    /// Failed to lookup aggregate audio device composition.
    case failedToLookupAggregateComposition(message: String? = nil)
    
    /// Object has no owner.
    case objectHasNoOwner
    
    /// No bundle ID was returned for the audio object.
    case noBundleIDForAudioObject(audioObjectID: UInt32)

    /// Feature is not yet implemented.
    case notYetImplemented(message: String? = nil)
    
    /// `OSStatus` error returned by a Core Audio method.
    case osStatus(AudioOSStatusError, message: String? = nil)
    
    /// PID does not exist.
    case pidDoesNotExist(pid: PID)
    
    /// Audio tap creation failed.
    case tapCreationFailed(message: String? = nil)
    
    /// Incorrect object type.
    case incorrectObjectType(message: String? = nil)
    
    /// Invalid aggregate audio device configuration.
    case invalidAggregateConfiguration(message: String? = nil)
}

extension SwiftCoreAudioError: Equatable { }

extension SwiftCoreAudioError: Hashable { }

extension SwiftCoreAudioError: Sendable { }

extension SwiftCoreAudioError: LocalizedError {
    nonisolated
    public var errorDescription: String? {
        switch self {
//        case let .aggregateAlreadyExists(uid: uid):
//            "Aggregate audio device could not be created because an aggregate with the UID \(uid) already exists in the system."
        
        case .aggregateCreationTimeout:
            "Aggregate audio device creation timeout."
        
        case let .aggregateCreationFailed(message: message):
            "Aggregate audio device creation failed. \(message ?? "")"
                .trimmingCharacters(in: .whitespacesAndNewlines)
            
        case .aggregateDestructionTimeout:
            "Aggregate audio device destruction timeout."
        
        case .audioBoxNotFound:
            "Core Audio AudioBox not found."
        
        case let .failedToLookupAggregateComposition(message: message):
            "Failed to lookup aggregate audio device composition. \(message ?? "")"
                .trimmingCharacters(in: .whitespacesAndNewlines)
        
        case .objectHasNoOwner:
            "Object has no owner."
            
        case let .noBundleIDForAudioObject(audioObjectID: id):
            "No bundle ID was returned for audio object with ID: \(id)"
        
        case let .notYetImplemented(message: message):
            "Not yet implemented. \(message ?? "")"
                .trimmingCharacters(in: .whitespacesAndNewlines)
        
        case let .osStatus(osStatusError, message):
            if let message { "\(osStatusError) (\(message))" } else { "\(osStatusError)" }
            
        case let .pidDoesNotExist(pid: pid):
            "PID \(pid) does not exist."
            
        case let .tapCreationFailed(message: message):
            "Tap creation failed. \(message ?? "")"
                .trimmingCharacters(in: .whitespacesAndNewlines)
            
        case let .incorrectObjectType(message: message):
            "Incorrect object type. \(message ?? "")"
                .trimmingCharacters(in: .whitespacesAndNewlines)
            
        case let .invalidAggregateConfiguration(message: message):
            "Invalid aggregate audio device configuration. \(message ?? "")"
                .trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
}

extension SwiftCoreAudioError: CustomStringConvertible {
    public var description: String {
        localizedDescription
    }
}

extension SwiftCoreAudioError: CustomDebugStringConvertible {
    public var debugDescription: String {
        localizedDescription
    }
}

// MARK: - Static Constructors

extension SwiftCoreAudioError {
    /// Construct from an ``AudioOSStatus`` instance.
    /// 
    /// This constructor only returns `nil` if the status is ``AudioOSStatus/noError`` (the `OSStatus` `noErr` constant).
    /// 
    /// `AudioOSStatus` is designed to 1:1 correspond to `OSStatus` status values, but the statuses include a `noErr`
    /// constant. This constant is not actually an error, but rather represents the absence of an error.
    /// As such, it should not be possible for an error type to be constructed from a non-error `OSStatus` value.
    nonisolated
    public static func osStatus(_ status: AudioOSStatus, message: String? = nil) -> Self? {
        guard let error = status.rawValue.audioOSStatusError() else { return nil }
        return .osStatus(error, message: message)
    }
}
