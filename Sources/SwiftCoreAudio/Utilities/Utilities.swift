//
//  Utilities.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

/// Encodes a four-character string as a `FourCharCode` (`UInt32`).
func fourCharCode(_ chars: StaticString) -> FourCharCode {
    chars.withUTF8Buffer { ptr in
        assert(ptr.count == 4)
        return FourCharCode(ptr[0]) << 24
            + FourCharCode(ptr[1]) << 16
            + FourCharCode(ptr[2]) << 8
            + FourCharCode(ptr[3])
    }
}

extension String {
    /// Decodes a `FourCharCode` (`UInt32`) into a human-readable string.
    init?(fourCharCode value: FourCharCode) {
        let b0 = UInt8((value >> 24) & 0xFF)
        let b1 = UInt8((value >> 16) & 0xFF)
        let b2 = UInt8((value >>  8) & 0xFF)
        let b3 = UInt8((value >>  0) & 0xFF)
        
        func isPrintable(_ byte: UInt8) -> Bool { (0x20 ... 0x7E).contains(byte) }
        guard [b0, b1, b2, b3].allSatisfy(isPrintable(_:)) else { return nil }
        
        let chars = [b0, b1, b2, b3].map(UnicodeScalar.init).map(Character.init)
        let string = String(chars)
        self = string
    }
}

/// Converts a `FourCharCode` (`UInt32`) to `OSStatus` (`Int32`).
func osStatus(fourCharCode chars: StaticString) -> OSStatus {
    chars.withUTF8Buffer { ptr in
        assert(ptr.count == 4)
        return OSStatus(bitPattern: fourCharCode(chars))
    }
}
