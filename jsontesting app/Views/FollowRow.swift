//
//  FollowRow.swift
//  jsontesting app
//
//  Created by Divyansh Bhardwaj on 21/12/23.
//

import SwiftUI

struct FollowRow: View {
    let follower: Follower

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: follower.avatar_url ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
            } placeholder: {
                Circle()
                    .foregroundColor(.secondary)
            }
            .frame(width: 50, height: 50)
            
            Text(follower.login)
                .font(.title2)
                .fontWeight(.semibold)
                .scaledToFit()
                .minimumScaleFactor(0.5)
                .padding()
        }
    }
}


#Preview {
    FollowRow(follower: MockData.sampleFollowers)
}
