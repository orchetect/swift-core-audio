//
//  SFSymbolsVersion.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

enum SFSymbolsVersion: Decimal {
    case v1_0 = 1.0
    case v1_1 = 1.1
    case v2_0 = 2.0
    case v2_1 = 2.1
    case v2_2 = 2.2
    case v3_0 = 3.0
    case v3_1 = 3.1
    case v3_2 = 3.2
    case v3_3 = 3.3
    case v4_0 = 4.0
    case v4_1 = 4.1
    case v4_2 = 4.2
    case v5_0 = 5.0
    case v5_1 = 5.1
    case v5_2 = 5.2
    case v5_3 = 5.3
    case v5_4 = 5.4
    case v6_0 = 6.0
    case v6_1 = 6.1
    case v6_2 = 6.2
    case v6_3 = 6.3
    case v6_4 = 6.4
    case v7_0 = 7.0
    case v7_1 = 7.1
    case v27_0 = 27.0
}

extension SFSymbolsVersion: Equatable { }

extension SFSymbolsVersion: Hashable { }

extension SFSymbolsVersion: Sendable { }

extension SFSymbolsVersion: CaseIterable { }

extension SFSymbolsVersion {
    var isAvailable: Bool {
        switch self {
        case .v1_0:
            if #available(macOS 11, macCatalyst 13, iOS 13, tvOS 13, watchOS 6, visionOS 1, *) {
                true
            } else { false }
        case .v1_1:
            if #available(macOS 11, macCatalyst 13.1, iOS 13.1, tvOS 13, watchOS 6.1, visionOS 1, *) {
                true
            } else { false }
        case .v2_0:
            if #available(macOS 11, macCatalyst 14, iOS 14, tvOS 14, watchOS 7, visionOS 1, *) {
                true
            } else { false }
        case .v2_1:
            if #available(macOS 11, macCatalyst 14.2, iOS 14.2, tvOS 14.2, watchOS 7.1, visionOS 1, *) {
                true
            } else { false }
        case .v2_2:
            if #available(macOS 11.3, macCatalyst 14.5, iOS 14.5, tvOS 14.5, watchOS 7.4, visionOS 1, *) {
                true
            } else { false }
        case .v3_0:
            if #available(macOS 12, macCatalyst 15, iOS 15, tvOS 15, watchOS 8, visionOS 1, *) {
                true
            } else { false }
        case .v3_1:
            if #available(macOS 12, macCatalyst 15.1, iOS 15.1, tvOS 15.1, watchOS 8.1, visionOS 1, *) {
                true
            } else { false }
        case .v3_2:
            if #available(macOS 12.1, macCatalyst 15.2, iOS 15.2, tvOS 15.2, watchOS 8.3, visionOS 1, *) {
                true
            } else { false }
        case .v3_3:
            if #available(macOS 12.3, macCatalyst 15.4, iOS 15.4, tvOS 15.4, watchOS 8.5, visionOS 1, *) {
                true
            } else { false }
        case .v4_0:
            if #available(macOS 13, macCatalyst 16, iOS 16, tvOS 16, watchOS 9, visionOS 1, *) {
                true
            } else { false }
        case .v4_1:
            if #available(macOS 13, macCatalyst 16.1, iOS 16.1, tvOS 16.1, watchOS 9.1, visionOS 1, *) {
                true
            } else { false }
        case .v4_2:
            if #available(macOS 13.3, macCatalyst 16.4, iOS 16.4, tvOS 16.4, watchOS 9.4, visionOS 1, *) {
                true
            } else { false }
        case .v5_0:
            if #available(macOS 14, macCatalyst 17, iOS 17, tvOS 17, watchOS 10, visionOS 1, *) {
                true
            } else { false }
        case .v5_1:
            if #available(macOS 14.1, macCatalyst 17.1, iOS 17.1, tvOS 17.1, watchOS 10.1, visionOS 1, *) {
                true
            } else { false }
        case .v5_2:
            if #available(macOS 14.2, macCatalyst 17.2, iOS 17.2, tvOS 17.2, watchOS 10.2, visionOS 1.1, *) {
                true
            } else { false }
        case .v5_3:
            if #available(macOS 14.4, macCatalyst 17.4, iOS 17.4, tvOS 17.4, watchOS 10.4, visionOS 1.1, *) {
                true
            } else { false }
        case .v5_4:
            if #available(macOS 14.6, macCatalyst 17.6, iOS 17.6, tvOS 17.6, watchOS 10.6, visionOS 1.3, *) {
                true
            } else { false }
        case .v6_0:
            if #available(macOS 15, macCatalyst 18, iOS 18, tvOS 18, watchOS 11, visionOS 2, *) {
                true
            } else { false }
        case .v6_1:
            if #available(macOS 15.1, macCatalyst 18.1, iOS 18.1, tvOS 18.1, watchOS 11.1, visionOS 2.1, *) {
                true
            } else { false }
        case .v6_2:
            if #available(macOS 15.2, macCatalyst 18.2, iOS 18.2, tvOS 18.2, watchOS 11.2, visionOS 2.2, *) {
                true
            } else { false }
        case .v6_3:
            if #available(macOS 15.4, macCatalyst 18.4, iOS 18.4, tvOS 18.4, watchOS 11.4, visionOS 2.4, *) {
                true
            } else { false }
        case .v6_4:
            if #available(macOS 15.5, macCatalyst 18.5, iOS 18.5, tvOS 18.5, watchOS 11.5, visionOS 2.5, *) {
                true
            } else { false }
        case .v7_0:
            if #available(macOS 26, macCatalyst 26, iOS 26, tvOS 26, watchOS 26, visionOS 26, *) {
                true
            } else { false }
        case .v7_1:
            if #available(macOS 26.1, macCatalyst 26.1, iOS 26.1, tvOS 26.1, watchOS 26.1, visionOS 26.1, *) {
                true
            } else { false }
        case .v27_0:
            if #available(macOS 27, macCatalyst 27, iOS 27, tvOS 27, watchOS 27, visionOS 27, *) {
                true
            } else { false }
        }
    }
}
