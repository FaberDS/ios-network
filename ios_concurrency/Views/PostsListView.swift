//
//  PostListView.swift
//  ios_concurrency
//
//  Created by Denis Schüle on 25.04.23.
//

import SwiftUI

struct PostsListView: View {
    
    @StateObject var vm = PostListViewModels()
    var userId: Int?
    var body: some View {
        NavigationView {
            List{
                ForEach(vm.posts) { post in
                    VStack(alignment: .leading){
                        Text(post.title)
                            .font(.headline)
                        Text(post.body)
                            .font(.callout)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .overlay(content: {
                if vm.isLoading {
                    ProgressView()
                }
            })
            .alert("ApplicationErrror", isPresented: $vm.showAlert,actions:{
                Button("Ok"){}
            }, message: {
                if let errorMessage = vm.errorMessage {
                    Text(errorMessage)
                }
            })
            .navigationTitle("Posts")
                .navigationBarTitleDisplayMode(.inline)
                .listStyle(.plain)
                .onAppear {
                    vm.userId = userId
                    vm.fetchPosts()
                }
        }
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PostsListView(userId: 1)
        }
    }
}
