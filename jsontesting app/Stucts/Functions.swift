//
//  Functions.swift
//  jsontesting app
//
//  Created by Divyansh Bhardwaj on 14/12/23.
//

import Foundation

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


func getFollowers() async throws -> [Follower] {
    let endpoint = "https://api.github.com/users/dbhardwaj99/followers"
    guard let url = URL(string: endpoint) else {
        throw GHError.invalidURL
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)

    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
        throw GHError.invalidResponse
    }
    
    do {
        let decoder = JSONDecoder()
        let followers = try decoder.decode([Follower].self, from: data)
            
        return followers
    } catch {
        print("Decoding error: \(error)")
        throw GHError.invalidData
    }
}

func getFollowing() async throws -> [Follower] {
    let endpoint = "https://api.github.com/users/dbhardwaj99/following"
    guard let url = URL(string: endpoint) else {
        throw GHError.invalidURL
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)

    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
        throw GHError.invalidResponse
    }
    
    do {
        let decoder = JSONDecoder()
        let followers = try decoder.decode([Follower].self, from: data)
            
        return followers
    } catch {
        print("Decoding error: \(error)")
        throw GHError.invalidData
    }
}

final class ViewModel: ObservableObject {
    var selectedUser: Follower?
    @Published var isShowingSafariView = false
}
