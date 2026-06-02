//
//  SnapshotModel.swift
//  Swift Core Audio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftUI
import SwiftCoreAudio

@Observable final class SnapshotModel {
    @MainActor
    var snapshot: AudioObjectSnapshot?
    
    @MainActor
    var selectedIDs: Set<AudioObjectSnapshot.ID> = []
    
    @MainActor
    var sidebarSearchText: String = ""
    
    @MainActor
    var propertiesSearchText: String = ""
    
    nonisolated
    init() { }
}

extension SnapshotModel {
    @concurrent
    func update(from snapshot: AudioObjectSnapshot?) async {
        if let snapshot {
            await MainActor.run {
                self.snapshot = snapshot
                selectedIDs = [snapshot.id] // select self
            }
        } else {
            await reset()
        }
    }
    
    @concurrent
    func reset() async {
        await MainActor.run {
            snapshot = nil
            selectedIDs = []
        }
    }
}

extension SnapshotModel {
    var selectedChildren: [AudioObjectSnapshot] {
        var snapshots: [AudioObjectSnapshot] = []
        if let snapshot, selectedIDs.contains(snapshot.id) {
            snapshots.append(snapshot)
        }
        let children = snapshot?.children.filter { selectedIDs.contains($0.id) }
            ?? []
        snapshots.append(contentsOf: children)
        return snapshots
    }
}

extension SnapshotModel {
    func snapshot(for objectID: Int) -> AudioObjectSnapshot? {
        if let snapshot, snapshot.objectID == objectID {
            snapshot
        } else {
            snapshot?
                .children
                .first(where: { $0.objectID == objectID })
        }
    }
    
    func name(for objectID: Int) -> String? {
        let snapshot = snapshot(for: objectID)
        return name(for: snapshot)
    }
    
    func name(for snapshot: AudioObjectSnapshot?) -> String? {
        if let name = snapshot?.properties[.object(.name)], !name.isEmpty {
            return name
        }
        
        // use preferable substitutions for specific classes where appropriate
        guard let classID = classID(for: snapshot) else { return nil }
        let proposedString: String?
        switch classID {
        case .process:
            let pid = snapshot?.properties[.process(.pid)]
            let bundleID = snapshot?.properties[.process(.bundleID)]
            if let pid, let bundleID, !pid.contains(" ") {
                proposedString = "\(pid) - \(bundleID)"
            } else if let pid {
                proposedString = "\(pid)"
            } else if let bundleID {
                proposedString = "\(bundleID)"
            } else {
                proposedString = nil
            }
        default:
            proposedString = nil
        }
        
        // otherwise, fallback to name of class
        return proposedString ?? classID.name
    }
    
    func nameForSelectedChildren() -> String? {
        switch selectedIDs.count {
        case 0:
            nil
        case 1 ... 5:
            selectedChildren
                .prefix(5)
                .map { self.name(for: $0) ?? "Unknown Object" }
                .joined(separator: ", ")
        default:
            if let firstSelectedChild = selectedChildren.first {
                "\(name(for: firstSelectedChild) ?? "Unknown Object") + \(selectedIDs.count - 1) more"
            } else {
                nil
            }
        }
    }
    
    func imageName(for snapshot: AudioObjectSnapshot?) -> String? {
        classID(for: snapshot)?
            .systemImageName
    }
    
    func classID(for snapshot: AudioObjectSnapshot?) -> AudioObjectClassID? {
        guard let rawString = snapshot?.properties[.object(.classID)]
            ?? snapshot?.properties[.object(.baseClassID)]
        else { return nil }
        guard let rawValue = UInt32(rawString) else { return nil }
        return AudioObjectClassID(rawValue: rawValue)
    }
}
