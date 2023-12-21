//
//  structures.swift
//  jsontesting app
//
//  Created by Divyansh Bhardwaj on 21/12/23.
//

import Foundation

struct MockData {
    static let sampleFollowers = Follower(id: 1, login: "john_doe", avatar_url: "https://example.com/avatar1.jpg", html_url: "https://github.com/saumtastic")
    
    static let somefollowers: [Follower] = [
            Follower(id: 1, login: "john_doe", avatar_url: "https://example.com/avatar1.jpg", html_url: "https://github.com/saumtastic"),
            Follower(id: 2, login: "jane_doe", avatar_url: "https://example.com/avatar2.jpg", html_url: "https://github.com/saumtastic"),
            Follower(id: 3, login: "alice_smith", avatar_url: "https://example.com/avatar3.jpg", html_url: "https://github.com/saumtastic"),
            Follower(id: 4, login: "bob_johnson", avatar_url: "https://example.com/avatar4.jpg", html_url: "https://github.com/saumtastic"),
        ]
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

struct Follower: Identifiable, Codable {
    let id: Int
    let login: String
    let avatar_url: String?
    let html_url: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatar_url = "avatar_url"
        case html_url = "html_url"
    }
}

