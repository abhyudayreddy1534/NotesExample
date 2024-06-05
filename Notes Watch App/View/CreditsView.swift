//
//  CreditsView.swift
//  Notes Watch App
//
//  Created by Sravanthi Chinthireddy on 05/06/24.
//  Copyright © 2024 Abhyuday Reddy Nandikonda. All rights reserved.
//

import SwiftUI

struct CreditsView: View {
    @State private var randomNum: Int = Int.random(in: 1..<4)
    
    private var randomImage: String {
        return "developer-no\(randomNum)"
    }
    var body: some View {
        VStack(spacing: 3, content: {
            Image(randomImage)
                .resizable()
                .scaledToFit()
                .layoutPriority(1)
            
            Text("Credits")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(.accent)
            HStack(content: {
                Capsule()
                    .frame(height: 1)
                
                Image(systemName: "note.text")
                
                Capsule()
                    .frame(height: 1)
            })
            .foregroundStyle(.accent)
            
            
            Text("Abhyuday Nandikonda")
                .foregroundStyle(.primary)
                .fontWeight(.bold)
            
            Text("Developer")
                .font(.footnote)
                .foregroundStyle(.secondary)
                .fontWeight(.light)
        })
    }
}

#Preview {
    CreditsView()
}
