//
//  AudioObjectPropertyAddress+Description.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

import CoreAudio

// Provide a more useful string output for debugging and error logging.
extension AudioObjectPropertyAddress: @retroactive CustomStringConvertible {
    public var description: String {
        let selector = if let s = String(fourCharCode: mSelector) {
            "\"\(s)\""
        } else {
            "\(mSelector)"
        }
        
        let scope = if let s = String(fourCharCode: mScope) {
            "\"\(s)\""
        } else {
            "\(mScope)"
        }
        
        let element = if let s = String(fourCharCode: mElement) {
            "\"\(s)\""
        } else {
            "\(mElement)"
        }
        
        return "Address selector: \(selector), scope: \(scope), element: \(element)"
    }
}

// Provide a more useful string output for debugging and error logging.
extension AudioObjectPropertyAddress: @retroactive CustomDebugStringConvertible {
    public var debugDescription: String {
        let selector = if let s = String(fourCharCode: mSelector) {
            "\"\(s)\" (\(mSelector))"
        } else {
            "\(mSelector)"
        }
        
        let scope = if let s = String(fourCharCode: mScope) {
            "\"\(s)\" (\(mScope))"
        } else {
            "\(mScope)"
        }
        
        let element = if let s = String(fourCharCode: mElement) {
            "\"\(s)\" (\(mElement))"
        } else {
            "\(mElement)"
        }
        
        return "AudioObjectPropertyAddress(selector: \(selector), scope: \(scope), element: \(element))"
    }
}

#endif
