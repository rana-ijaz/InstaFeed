//
//  AutoPlayVideoPlayer.swift
//  InstaFeed
//
//  Created by Rana Ijaz Ahmad on 25/04/2025.
//

import SwiftUI
import AVKit

struct AutoPlayVideoPlayer: View {
    let videoName: String
    @State private var player: AVPlayer? = nil
    @State private var isVisible: Bool = false

    var body: some View {
        GeometryReader { geo in
            VideoPlayer(player: player)
                .onAppear {
                    if player == nil {
                        if let url = Bundle.main.url(forResource: videoName, withExtension: "mp4") {
                            player = AVPlayer(url: url)
                            player?.actionAtItemEnd = .none
                            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime,
                                                                   object: player?.currentItem,
                                                                   queue: .main) { _ in
                                player?.seek(to: .zero)
                                player?.play()
                            }
                        }
                    }
                }
                .onChange(of: isVisible) { visible in
                    if visible {
                        player?.play()
                    } else {
                        player?.pause()
                    }
                }
                .onDisappear {
                    player?.pause()
                    player = nil
                }
                .modifier(VisibilityDetector(threshold: 0.6, isVisible: $isVisible))
        }
        .frame(height: 300)
        .cornerRadius(10)
    }
}
