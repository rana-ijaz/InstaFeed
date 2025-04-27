//
//  Post.swift
//  InstaFeed
//
//  Created by Rana Ijaz Ahmad on 24/04/2025.
//

import Foundation

enum MediaType {
    case image(name: String)
    case video(name: String)
    case imageAndVideo(imageName: String, videoName: String)
}

struct Post: Identifiable {
    let id = UUID()
    let username: String
    let userImage: String
    let media: MediaType
    let caption: String
}
