//
//  Asset Previews.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if DEBUG && !GITHUB_ACTIONS

import Foundation
import SwiftUI

/// These SwiftUI previews are a basic development harness for testing the custom SF Symbols included
/// in the library within the Xcode IDE in order to observe how they behave under various layout constraints.
///
/// Red borders represent "target" bounds, and yellow borders reflect real image view bounds.
@available(macOS 14.0, iOS 17.0, tvOS 18.0, watchOS 10.0, visionOS 1.0, *)
#Preview("Custom SF Symbol Layout Test", traits: .sizeThatFitsLayout) {
    @Previewable @State var isTargetBoundsOn: Bool = true
    @Previewable @State var isActualBoundsOn: Bool = true

    Form {
        Toggle("Show Target Bounds", isOn: $isTargetBoundsOn)
        Toggle("Show Actual Bounds", isOn: $isActualBoundsOn)
    }
    .formStyle(.grouped)
    .toggleStyle(.switch)
    .fixedSize()

    let targetColor: Color = isTargetBoundsOn ? .red : .clear
    let actualColor: Color = isActualBoundsOn ? .yellow : .clear

    VStack(spacing: 10) {
        // Default Size
        HStack(spacing: 20) {
            Image(systemName: "document.on.trash")
                .border(actualColor)
            Image(systemName: "mic")
                .border(actualColor)
            Image(systemName: "folder")
                .border(actualColor)
            Image(systemName: "person.3.sequence")
                .border(actualColor)
            Image(systemName: "macmini")
                .border(actualColor)
            Image(.blackHoleSymbol)
                .border(actualColor)
            Image(.blackHoleNarrowSymbol)
                .border(actualColor)
            // (`.blackHoleIcon` omitted; is a raster image and not a Symbol)
        }

        // Small
        HStack(spacing: 20) {
            Image(systemName: "document.on.trash")
                .border(actualColor)
            Image(systemName: "mic")
                .border(actualColor)
            Image(systemName: "folder")
                .border(actualColor)
            Image(systemName: "person.3.sequence")
                .border(actualColor)
            Image(systemName: "macmini")
                .border(actualColor)
            Image(.blackHoleSymbol)
                .border(actualColor)
            Image(.blackHoleNarrowSymbol)
                .border(actualColor)
            // (`.blackHoleIcon` omitted; is a raster image and not a Symbol)
        }
        .imageScale(.small)

        // Medium
        HStack(spacing: 20) {
            Image(systemName: "document.on.trash")
                .border(actualColor)
            Image(systemName: "mic")
                .border(actualColor)
            Image(systemName: "folder")
                .border(actualColor)
            Image(systemName: "person.3.sequence")
                .border(actualColor)
            Image(systemName: "macmini")
                .border(actualColor)
            Image(.blackHoleSymbol)
                .border(actualColor)
            Image(.blackHoleNarrowSymbol)
                .border(actualColor)
            // (`.blackHoleIcon` omitted; is a raster image and not a Symbol)
        }
        .imageScale(.medium)

        // Large
        HStack(spacing: 20) {
            Image(systemName: "document.on.trash")
                .border(actualColor)
            Image(systemName: "mic")
                .border(actualColor)
            Image(systemName: "folder")
                .border(actualColor)
            Image(systemName: "person.3.sequence")
                .border(actualColor)
            Image(systemName: "macmini")
                .border(actualColor)
            Image(.blackHoleSymbol)
                .border(actualColor)
            Image(.blackHoleNarrowSymbol)
                .border(actualColor)
            // (`.blackHoleIcon` omitted; is a raster image and not a Symbol)
        }
        .imageScale(.large)

        // Scale to Fit - 28x28
        HStack(spacing: 20) {
            Image(systemName: "document.on.trash")
                .resizable()
                .scaledToFit()
                .border(actualColor)
                .frame(width: 28, height: 28)
                .overlay { Rectangle().fill(.clear).border(targetColor).frame(width: 28, height: 28) }
            Image(systemName: "mic")
                .resizable()
                .scaledToFit()
                .border(actualColor)
                .frame(width: 28, height: 28)
                .overlay { Rectangle().fill(.clear).border(targetColor).frame(width: 28, height: 28) }
            Image(systemName: "folder")
                .resizable()
                .scaledToFit()
                .border(actualColor)
                .frame(width: 28, height: 28)
                .overlay { Rectangle().fill(.clear).border(targetColor).frame(width: 28, height: 28) }
            Image(systemName: "person.3.sequence")
                .resizable()
                .scaledToFit()
                .border(actualColor)
                .frame(width: 28, height: 28)
                .overlay { Rectangle().fill(.clear).border(targetColor).frame(width: 28, height: 28) }
            Image(systemName: "macmini")
                .resizable()
                .scaledToFit()
                .border(actualColor)
                .frame(width: 28, height: 28)
                .overlay { Rectangle().fill(.clear).border(targetColor).frame(width: 28, height: 28) }
            Image(.blackHoleSymbol)
                .resizable()
                .scaledToFit()
                .border(actualColor)
                .frame(width: 28, height: 28)
                .overlay { Rectangle().fill(.clear).border(targetColor).frame(width: 28, height: 28) }
            Image(.blackHoleNarrowSymbol)
                .resizable()
                .scaledToFit()
                .border(actualColor)
                .frame(width: 28, height: 28)
                .overlay { Rectangle().fill(.clear).border(targetColor).frame(width: 28, height: 28) }
            Image(.blackHoleIcon)
                .resizable()
                .scaledToFit()
                .border(actualColor)
                .frame(width: 28, height: 28)
                .overlay { Rectangle().fill(.clear).border(targetColor).frame(width: 28, height: 28) }
        }

        // Scale to Fit - 40x40
        HStack(spacing: 20) {
            Image(systemName: "document.on.trash")
                .resizable()
                .scaledToFit()
                .border(actualColor)
                .frame(width: 40, height: 40)
                .overlay { Rectangle().fill(.clear).border(targetColor).frame(width: 40, height: 40) }
            Image(systemName: "mic")
                .resizable()
                .scaledToFit()
                .border(actualColor)
                .frame(width: 40, height: 40)
                .overlay { Rectangle().fill(.clear).border(targetColor).frame(width: 40, height: 40) }
            Image(systemName: "folder")
                .resizable()
                .scaledToFit()
                .border(actualColor)
                .frame(width: 40, height: 40)
                .overlay { Rectangle().fill(.clear).border(targetColor).frame(width: 40, height: 40) }
            Image(systemName: "person.3.sequence")
                .resizable()
                .scaledToFit()
                .border(actualColor)
                .frame(width: 40, height: 40)
                .overlay { Rectangle().fill(.clear).border(targetColor).frame(width: 40, height: 40) }
            Image(systemName: "macmini")
                .resizable()
                .scaledToFit()
                .border(actualColor)
                .frame(width: 40, height: 40)
                .overlay { Rectangle().fill(.clear).border(targetColor).frame(width: 40, height: 40) }
            Image(.blackHoleSymbol)
                .resizable()
                .scaledToFit()
                .border(actualColor)
                .frame(width: 40, height: 40)
                .overlay { Rectangle().fill(.clear).border(targetColor).frame(width: 40, height: 40) }
            Image(.blackHoleNarrowSymbol)
                .resizable()
                .scaledToFit()
                .border(actualColor)
                .frame(width: 40, height: 40)
                .overlay { Rectangle().fill(.clear).border(targetColor).frame(width: 40, height: 40) }
            Image(.blackHoleIcon)
                .resizable()
                .scaledToFit()
                .border(actualColor)
                .frame(width: 40, height: 40)
                .overlay { Rectangle().fill(.clear).border(targetColor).frame(width: 40, height: 40) }
        }

        // Font size - 20
        HStack(spacing: 20) {
            Image(systemName: "document.on.trash")
                .font(.system(size: 20))
                .border(actualColor)
                .overlay { Rectangle().fill(.clear).border(targetColor).frame(width: 20, height: 20) }
            Image(systemName: "mic")
                .font(.system(size: 20))
                .border(actualColor)
                .overlay { Rectangle().fill(.clear).border(targetColor).frame(width: 20, height: 20) }
            Image(systemName: "folder")
                .font(.system(size: 20))
                .border(actualColor)
                .overlay { Rectangle().fill(.clear).border(targetColor).frame(width: 20, height: 20) }
            Image(systemName: "person.3.sequence")
                .font(.system(size: 20))
                .border(actualColor)
                .overlay { Rectangle().fill(.clear).border(targetColor).frame(width: 20, height: 20) }
            Image(systemName: "macmini")
                .font(.system(size: 20))
                .border(actualColor)
                .overlay { Rectangle().fill(.clear).border(targetColor).frame(width: 20, height: 20) }
            Image(.blackHoleSymbol)
                .font(.system(size: 20))
                .border(actualColor)
                .overlay { Rectangle().fill(.clear).border(targetColor).frame(width: 20, height: 20) }
            Image(.blackHoleNarrowSymbol)
                .font(.system(size: 20))
                .border(actualColor)
                .overlay { Rectangle().fill(.clear).border(targetColor).frame(width: 20, height: 20) }
            Image(.blackHoleIcon)
                .resizable()
                .scaledToFit()
                .font(.system(size: 20)) // has no effect on a raster image; only affects SF Symbols
                .border(actualColor)
                .overlay { Rectangle().fill(.clear).border(targetColor).frame(width: 20, height: 20) }
        }

        // Font size - 40
        HStack(spacing: 20) {
            Image(systemName: "document.on.trash")
                .font(.system(size: 40))
                .border(actualColor)
                .overlay { Rectangle().fill(.clear).border(targetColor).frame(width: 40, height: 40) }
            Image(systemName: "mic")
                .font(.system(size: 40))
                .border(actualColor)
                .overlay { Rectangle().fill(.clear).border(targetColor).frame(width: 40, height: 40) }
            Image(systemName: "folder")
                .font(.system(size: 40))
                .border(actualColor)
                .overlay { Rectangle().fill(.clear).border(targetColor).frame(width: 40, height: 40) }
            Image(systemName: "person.3.sequence")
                .font(.system(size: 40))
                .border(actualColor)
                .overlay { Rectangle().fill(.clear).border(targetColor).frame(width: 40, height: 40) }
            Image(systemName: "macmini")
                .font(.system(size: 40))
                .border(actualColor)
                .overlay { Rectangle().fill(.clear).border(targetColor).frame(width: 40, height: 40) }
            Image(.blackHoleSymbol)
                .font(.system(size: 40))
                .border(actualColor)
                .overlay { Rectangle().fill(.clear).border(targetColor).frame(width: 40, height: 40) }
            Image(.blackHoleNarrowSymbol)
                .font(.system(size: 40))
                .border(actualColor)
                .overlay { Rectangle().fill(.clear).border(targetColor).frame(width: 40, height: 40) }
            Image(.blackHoleIcon)
                .resizable()
                .scaledToFit()
                .font(.system(size: 40)) // has no effect on a raster image; only affects SF Symbols
                .border(actualColor)
                .overlay { Rectangle().fill(.clear).border(targetColor).frame(width: 40, height: 40) }
        }

        // Font size - 80
        HStack(spacing: 20) {
            Image(systemName: "document.on.trash")
                .font(.system(size: 80))
                .border(actualColor)
                .overlay { Rectangle().fill(.clear).border(targetColor).frame(width: 80, height: 80) }
            Image(systemName: "mic")
                .font(.system(size: 80))
                .border(actualColor)
                .overlay { Rectangle().fill(.clear).border(targetColor).frame(width: 80, height: 80) }
            Image(systemName: "folder")
                .font(.system(size: 80))
                .border(actualColor)
                .overlay { Rectangle().fill(.clear).border(targetColor).frame(width: 80, height: 80) }
            Image(systemName: "person.3.sequence")
                .font(.system(size: 80))
                .border(actualColor)
                .overlay { Rectangle().fill(.clear).border(targetColor).frame(width: 80, height: 80) }
            Image(systemName: "macmini")
                .font(.system(size: 80))
                .border(actualColor)
                .overlay { Rectangle().fill(.clear).border(targetColor).frame(width: 80, height: 80) }
            Image(.blackHoleSymbol)
                .font(.system(size: 80))
                .border(actualColor)
                .overlay { Rectangle().fill(.clear).border(targetColor).frame(width: 80, height: 80) }
            Image(.blackHoleNarrowSymbol)
                .font(.system(size: 80))
                .border(actualColor)
                .overlay { Rectangle().fill(.clear).border(targetColor).frame(width: 80, height: 80) }
            Image(.blackHoleIcon)
                .resizable()
                .scaledToFit()
                .font(.system(size: 80)) // has no effect on a raster image; only affects SF Symbols
                .border(actualColor)
                .overlay { Rectangle().fill(.clear).border(targetColor).frame(width: 80, height: 80) }
        }
    }
    .padding()
    .frame(width: 1200)
}

#endif
