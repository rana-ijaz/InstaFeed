//
//  MediaView.swift
//  InstaFeed
//
//  Created by Rana Ijaz Ahmad on 25/04/2025.
//

import SwiftUI
import AVKit

struct MediaView: View {
    let media: MediaType
    @State private var cachedImage: UIImage? = nil  // Store the cached image

    var body: some View {
        switch media {
        case .image(let name):
            if let cachedImage = ImageCache.shared.getImage(forKey: name) {
                //self.cachedImage = cachedImage
                let _ = print(cachedImage)
            } else {
                if let uiImage = UIImage(named: name) {
                    let _ = print(uiImage)
                    //ImageCache.shared.setImage(uiImage, forKey: name)
                    //self.cachedImage = uiImage
                }
            }
            Image(name)
                .resizable()
                .scaledToFit()
                .cornerRadius(10)

        case .video(let name):
            AutoPlayVideoPlayer(videoName: name)

        case .imageAndVideo(let imageName, let videoName):
            HStack(spacing: 8) {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width * 0.45, height: 250)
                    .clipped()
                    .cornerRadius(10)

                AutoPlayVideoPlayer(videoName: videoName)
                    .frame(width: UIScreen.main.bounds.width * 0.45, height: 250)
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        
        // Like, Comment, and Share icons
        HStack(spacing: 20) {
            // Like icon
            Button(action: {
                // Handle like action
            }) {
                Image(systemName: "heart.fill")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.red)
            }

            // Comment icon
            Button(action: {
                // Handle comment action
            }) {
                Image(systemName: "bubble.right.fill")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.gray)
            }

            // Share icon
            Button(action: {
                // Handle share action
            }) {
                Image(systemName: "square.and.arrow.up")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.gray)
            }
        }
        .padding([.leading, .trailing])
    }
}


#Preview {
    MediaView(media: .image(name: "post2"))
}
