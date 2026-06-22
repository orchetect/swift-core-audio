//
//  FillerInfoView.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftCoreAudio
import SwiftUI

struct FillerInfoView: View {
    let systemImage: String
    let title: String

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: systemImage)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .shadow(color: .secondary.opacity(0.75), radius: 10, x: 0, y: 0)

            Text(title)
        }
        .foregroundStyle(.secondary)
        .padding(10)
        .frame(minWidth: 200, minHeight: 200)
    }
}
