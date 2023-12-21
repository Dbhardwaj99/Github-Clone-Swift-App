//
//  Followers.swift
//  jsontesting app
//
//  Created by Divyansh Bhardwaj on 14/12/23.
//

import SwiftUI

struct FollowersView: View {
    @Binding var showingFollowersSheet: Bool
    @StateObject var viewModel = ViewModel()
    @State private var followers: [Follower] = []
    
    var body: some View {
        NavigationView {
            List {
                ForEach(followers) { follower in
                    FollowRow(follower: follower)
                        .onTapGesture {
                            viewModel.selectedUser = follower
                            viewModel.isShowingSafariView = true
                        }
                }
            }
            .padding(-5)
            .navigationTitle("Followers")
            .task {
                do{
                    followers = try await getFollowers()
                } catch GHError.invalidURL{
                    print("Invalid URL")
                } catch GHError.invalidData{
                    print("Invalid Data")
                } catch GHError.invalidResponse{
                    print("Invalid Response")
                } catch{
                    print("Unexpected Error")
                }
            }
        }
        .fullScreenCover(isPresented: $viewModel.isShowingSafariView) {
            SafariView(url: URL(string: viewModel.selectedUser?.html_url ?? "www.apple.com")!)
        }
    }
}

#Preview {
    FollowersView(showingFollowersSheet: .constant(true))
}

