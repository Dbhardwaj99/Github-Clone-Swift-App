//
//  Following.swift
//  jsontesting app
//
//  Created by Divyansh Bhardwaj on 14/12/23.
//

import SwiftUI

struct FollowingView: View {
    @Binding var showingFollowingSheet: Bool
    @StateObject var viewModel = ViewModel()
    @State private var following: [Follower] = []
    var body: some View {
        NavigationView {
            List {
                ForEach(following) { following in
                    FollowRow(follower: following)
                        .onTapGesture {
                            viewModel.selectedUser = following
                            viewModel.isShowingSafariView = true
                        }
                }
            }
            .padding(-5)
            .navigationTitle("Following")
            .task {
                do{
                    following = try await getFollowing()
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
    FollowingView(showingFollowingSheet: .constant(true))
}

