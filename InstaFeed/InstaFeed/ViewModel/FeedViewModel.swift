//
//  FeedViewModel.swift
//  InstaFeed
//
//  Created by Rana Ijaz Ahmad on 24/04/2025.
//

import Foundation

class FeedViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var isLoadingMore = false

    private var repository: FeedRepositoryProtocol
    private var offset = 0
    private let limit = 4
    private var isLoading = false

    init(repository: FeedRepositoryProtocol = FeedRepository()) {
        self.repository = repository
        loadMorePosts()
    }

    func loadMorePosts() {
        guard !isLoading else { return }
        isLoading = true
        isLoadingMore = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let newPosts = self.repository.fetchPosts(offset: self.offset, limit: self.limit)
            self.posts.append(contentsOf: newPosts)
            self.offset += newPosts.count
            self.isLoading = false
            self.isLoadingMore = false
        }
    }
    
    func refreshPosts() {
        isLoading = true
        isLoadingMore = false
        offset = 0
        posts = []

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let newPosts = self.repository.fetchPosts(offset: self.offset, limit: self.limit)
            self.posts = newPosts
            self.offset = newPosts.count
            self.isLoading = false
        }
    }

}




