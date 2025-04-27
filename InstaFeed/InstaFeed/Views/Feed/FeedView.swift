//
//  FeedView.swift
//  InstaFeed
//
//  Created by Rana Ijaz Ahmad on 24/04/2025.
//

import SwiftUI

struct FeedView: View {
    @StateObject private var viewModel = FeedViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(Array(viewModel.posts.enumerated()), id: \.1.id) { index, post in
                        PostView(post: post)
                            .onAppear {
                                if index == viewModel.posts.count - 1 {
                                    viewModel.loadMorePosts()
                                }
                            }
                    }

                    if viewModel.isLoadingMore {
                        ProgressView()
                            .padding()
                    }
                }
                .padding()
            }
            .refreshable {
                viewModel.refreshPosts()
            }

            .navigationTitle("Instagram-Like Feed")
        }
    }
}


struct PostView: View {
    let post: Post

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(post.userImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                Text(post.username)
                    .fontWeight(.bold)
                Spacer()
            }

            MediaView(media: post.media)

            Text(post.caption)
                .font(.subheadline)
            
            // Time ago
            Text("2 hours ago")
                .font(.caption)
                .foregroundColor(.gray)
                .frame(alignment: .leading)
                .padding(.bottom, 10) // Padding under the timestamp
        }
    }
}


#Preview {
    FeedView()
    //PostView(post: Post(username: "user1", userImage: "user1", media: .image(name: "post1"), caption: "user1 caption"))
}
