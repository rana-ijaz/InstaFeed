//
//  ImageCache.swift
//  InstaFeed
//
//  Created by Rana Ijaz Ahmad on 26/04/2025.
//

import SwiftUI

class ImageCache {
    static let shared = ImageCache()
    private var cache = NSCache<NSString, UIImage>()

    func getImage(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }

    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}
