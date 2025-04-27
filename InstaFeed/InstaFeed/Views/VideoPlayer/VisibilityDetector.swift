//
//  VisibilityDetector.swift
//  InstaFeed
//
//  Created by Rana Ijaz Ahmad on 25/04/2025.
//
import SwiftUI
import AVKit

struct VisibilityDetector: ViewModifier {
    var threshold: CGFloat = 0.6
    @Binding var isVisible: Bool

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geo in
                    Color.clear
                        .preference(key: ViewVisibleKey.self, value: geo.frame(in: .global))
                }
            )
            .onPreferenceChange(ViewVisibleKey.self) { frame in
                let screenHeight = UIScreen.main.bounds.height
                let visibleHeight = max(0, min(frame.maxY, screenHeight) - max(frame.minY, 0))
                let visibilityRatio = visibleHeight / frame.height
                isVisible = visibilityRatio > threshold
            }
    }
}

struct ViewVisibleKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {}
}
