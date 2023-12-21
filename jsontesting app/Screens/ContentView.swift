//
//  ContentView.swift
//  jsontesting app
//
//  Created by Divyansh Bhardwaj on 12/12/23.
//

import SwiftUI

struct ContentView: View {
    @State private var user: githubUser?
    @State private var showingFollowersSheet = false
    @State private var showingFollowingSheet = false

    var body: some View {
        VStack(spacing:20) {
            Spacer()
            AsyncImage(url: URL(string: user?.avatarUrl ?? "")){
                image in image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            }placeholder: {
                Circle()
                    .foregroundColor(.secondary)
                    
            }.frame(width: 200, height: 200)
            
            Text(user?.login ?? "User")
                .bold()
                .font(.title3)
            
            Text(user?.bio ?? "Bio")
                .padding()
            
            Spacer()
            HStack{
                Button{
                    showingFollowersSheet = true
                }label: {
                    Buttons(title: "Followers")
                }
                
                Spacer()
                
                Button{
                    showingFollowingSheet = true
                }label: {
                    Buttons(title: "Followings")
                }
            }
            .sheet(isPresented: $showingFollowersSheet) {
                FollowersView(showingFollowersSheet: $showingFollowersSheet)
            }
            .sheet(isPresented: $showingFollowingSheet) {
                FollowingView(showingFollowingSheet: $showingFollowingSheet)
            }

            Spacer()
            
        }
        .padding()
        .task {
            do{
                user = try await getUser()
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
}

#Preview {
    ContentView()
}

