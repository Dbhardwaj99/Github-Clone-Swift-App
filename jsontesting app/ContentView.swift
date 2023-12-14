//
//  ContentView.swift
//  jsontesting app
//
//  Created by Divyansh Bhardwaj on 12/12/23.
//

import SwiftUI

struct ContentView: View {
    @State private var user: githubUser?
    var body: some View {
        VStack(spacing:20) {
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
            
            Text("Hiiiiiiiiii")
                .padding()
            
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
    
    func getUser() async throws -> githubUser{
        let endpoint = "https://api.github.com/users/dbhardwaj99"
        guard let url = URL(string: endpoint) else {
            throw GHError.invalidURL}
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
            throw GHError.invalidResponse
        }
        
        do{
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(githubUser.self, from: data)
        }catch{
            throw GHError.invalidData
        }
        
    }
}

#Preview {
    ContentView()
}

struct githubUser: Codable{
    let login : String
    let avatarUrl : String
    let bio : String
}

enum GHError: Error{
    case invalidURL
    case invalidResponse
    case invalidData
}
