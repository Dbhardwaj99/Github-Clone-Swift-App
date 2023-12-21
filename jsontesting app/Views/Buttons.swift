//
//  Buttons.swift
//  jsontesting app
//
//  Created by Divyansh Bhardwaj on 21/12/23.
//

import SwiftUI

struct Buttons: View {
    var title: String
    
    var body: some View {
        Text(title)
            .font(.title2)
            .fontWeight(.semibold)
            .frame(width: 130, height: 50)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(20)
            .padding()
    }
}

#Preview {
    Buttons(title: "AR Kit")
}
