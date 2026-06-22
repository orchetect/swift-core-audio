//
//  Receiver.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

actor Receiver<T> {
    var items: [T] = []

    init() { }

    func add(_ element: T) {
        print(element)
        items.append(element)
    }

    func reset() {
        items.removeAll()
    }
}
