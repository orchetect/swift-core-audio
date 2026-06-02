//
//  AudioObjectSnapshot Utilities.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

func withErrorCapture<Key: RawRepresentable>(
    key: Key,
    _ value: @autoclosure () throws(SwiftCoreAudioError) -> String?
) -> String? {
    do throws(SwiftCoreAudioError) {
        return try value()
    } catch {
        return "\(error)"
    }
}

func withErrorCapture<Key: RawRepresentable, T>(
    key: Key,
    _ value: @autoclosure () throws(SwiftCoreAudioError) -> T?,
    transform: (T) -> String?
) -> String? {
    do throws(SwiftCoreAudioError) {
        guard let rawValue = try value() else { return nil }
        let transformedValue = transform(rawValue)
        return transformedValue
    } catch {
        return "\(error)"
    }
}

func withErrorCapture<Key: RawRepresentable, T>(
    key: Key,
    _ value: @autoclosure () throws(SwiftCoreAudioError) -> T?,
    transform: KeyPath<T, String>
) -> String? {
    do throws(SwiftCoreAudioError) {
        let rawValue = try value()
        let transformedValue = rawValue?[keyPath: transform]
        return transformedValue
    } catch {
        return "\(error)"
    }
}

extension StringProtocol {
    func prefixingLines(with prefix: String) -> String {
        guard !prefix.isEmpty else { return String(self) }
        
        return split(separator: "\n")
            .map { "\(prefix)\($0)" }
            .joined(separator: "\n")
    }
}

#endif
