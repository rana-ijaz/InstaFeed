//
//  FeedRepository.swift
//  InstaFeed
//
//  Created by Rana Ijaz Ahmad on 26/04/2025.
//

import Foundation

protocol FeedRepositoryProtocol {
    func fetchPosts(offset: Int, limit: Int) -> [Post]
}

class FeedRepository: FeedRepositoryProtocol {
    private let allPosts: [Post]

    init() {
        let originalPosts = [
            Post(username: "john_doe", userImage: "user1", media: .image(name: "post1"), caption: "Enjoying the view!"),
            Post(username: "jane_smith", userImage: "user2", media: .video(name: "video1"), caption: "Morning vibes 🎥"),
            Post(username: "alexy_99", userImage: "user3", media: .image(name: "post3"), caption: "Nature lights ✨"),
            Post(username: "maria_lens", userImage: "user4", media: .imageAndVideo(imageName: "post2", videoName: "video1"), caption: "Throwback + some vibes 🎞️"
            )

        ]

        var repeated: [Post] = []
        for _ in 0..<3 {
            repeated += originalPosts.map {
                Post(username: $0.username, userImage: $0.userImage, media: $0.media, caption: $0.caption)
            }
        }

        allPosts = repeated
    }

    func fetchPosts(offset: Int, limit: Int) -> [Post] {
        let end = min(offset + limit, allPosts.count)
        guard offset < end else { return [] }
        return Array(allPosts[offset..<end])
    }
    
    func fetchFromLocalDB() {
        //Fetch from local DB if Internet is disconnected
    }
}


