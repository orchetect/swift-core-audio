//
//  AudioChannelIndex.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

/// Single (mono) channel index.
///
/// > Note:
/// >
/// > Channel numbers are presented to the end-user as a 1-based number series (not 0-based indexes).
/// > SwiftCoreAudio provides a `AudioChannelIndex` type which offers both a channel index
/// > a channel number property to avoid ambiguity.
public struct AudioChannelIndex {
    /// The index (0-based) for the channel.
    public var index: Int {
        didSet {
            assert(index >= 0)
        }
    }

    /// Construct a new instance from a channel index (0-based).
    public init(index: some BinaryInteger) {
        assert(index >= 0)
        self.index = Int(index)
    }
}

extension AudioChannelIndex: Equatable { }

extension AudioChannelIndex: Hashable { }

extension AudioChannelIndex: RawRepresentable {
    /// RawRepresentable proxy initializer from 0-based index.
    /// This initializer is the same as calling ``init(index:)`` except that this returns `nil` if the
    /// index is out-of-bounds (`< 0`).
    public init?(rawValue: Int) {
        guard rawValue >= 0 else { return nil }
        self.init(index: rawValue)
    }

    /// RawRepresentable proxy to get/set 0-based ``index``.
    public var rawValue: Int {
        get { index }
        set { index = newValue }
    }
}

extension AudioChannelIndex: Codable { }

extension AudioChannelIndex: Sendable { }

extension AudioChannelIndex: CustomStringConvertible {
    public var description: String {
        "\(index)"
    }
}

extension AudioChannelIndex: CustomDebugStringConvertible {
    public var debugDescription: String {
        "AudioChannelIndex(\(index))"
    }
}

// MARK: - Convenience Inits

extension AudioChannelIndex {
    /// Construct a new instance from a raw channel number (1-based).
    nonisolated
    public init(number: some BinaryInteger) {
        self.init(index: number - 1)
    }
}

// MARK: - Properties

extension AudioChannelIndex {
    /// Returns the user-facing channel number (1-based) for the channel.
    nonisolated
    public var number: Int {
        index + 1
    }
}
