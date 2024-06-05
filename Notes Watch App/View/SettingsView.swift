//
//  SettingsView.swift
//  Notes Watch App
//
//  Created by Sravanthi Chinthireddy on 05/06/24.
//  Copyright © 2024 Abhyuday Reddy Nandikonda. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("lineCount") var lineCount: Int = 1
    @State private var value: Float = 1.0
    
    func updateLineCount() {
        lineCount = Int(value)
    }
    
    var body: some View {
        VStack(spacing: 8,
               content: {
            
            Text("Settings")
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
            
            Text("Lines: \(lineCount)".uppercased())
                .fontWeight(.bold)
            Slider(
                value: Binding(get: { self.value },
                               set: { newValue in
                                   self.value = newValue
                                   self.updateLineCount()
                               }),
                in: 1...4,
                step: 1
            )
                .tint(.accent)
            
        })
    }
}

#Preview {
    SettingsView()
}
