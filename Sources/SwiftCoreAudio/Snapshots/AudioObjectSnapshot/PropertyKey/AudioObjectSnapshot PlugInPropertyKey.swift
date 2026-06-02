//
//  AudioObjectSnapshot PlugInPropertyKey.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) || targetEnvironment(macCatalyst)

extension AudioObjectSnapshot {
    /// Keys listed in the order they appear where their property getters are defined.
    public enum PlugInPropertyKey: String {
        // TODO: implement after implementing properties on AudioPlugIn
        case foo
    }
}

extension AudioObjectSnapshot.PlugInPropertyKey: AudioObjectSnapshot.PropertyKey {
    public var asAnyPropertyKey: AudioObjectSnapshot.AnyPropertyKey {
        .plugin(self)
    }
}

extension AudioObjectSnapshot.PlugInPropertyKey {
    public func getValue(of object: some AudioPlugInProperties) -> String? {
        // TODO: implement after implementing properties on AudioPlugIn
        switch self {
        case .foo: nil
        }
    }
}

#endif
