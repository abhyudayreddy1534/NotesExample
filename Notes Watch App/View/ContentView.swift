//
//  ContentView.swift
//  Notes Watch App
//
//  Created by Sravanthi Chinthireddy on 05/06/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("lineCount") var lineCount: Int = 1
    @State private var notes: [Note] = [Note]()
    @State private var text: String  = ""
    
    func getDocsDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    func save() {
//        dump(notes)
        do {
            let data = try JSONEncoder().encode(notes)
            let url = getDocsDirectory().appendingPathComponent("notes")
            try data.write(to: url)
        } catch {
            print("Failed to save the note.")
        }
    }
    
    func load() {
        DispatchQueue.main.async {
            do {
                let url = getDocsDirectory().appendingPathComponent("notes")
                let data = try Data(contentsOf: url)
                
                notes = try JSONDecoder().decode([Note].self, from: data)
            } catch {
                
            }
        }
        
    }
    
    func delete(offsets: IndexSet) {
        withAnimation {
            notes.remove(atOffsets: offsets)
            save()
        }
    }
    
    var body: some View {
        NavigationView(content: {
            VStack {
                HStack(alignment: .center, spacing: 6, content: {
                    TextField("Add New Note", text: $text)
                    
                    Button(action: {
                        guard text.isEmpty == false else { return }
                        
                        let note = Note(id: UUID(), text: text)
                        notes.append(note)
                        
                        text = ""
                        
                        save()
                    }, label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 42, weight: .semibold))
                    })
                    .fixedSize()
                    .buttonStyle(PlainButtonStyle())
                    .foregroundStyle(.accent)
                })
                Spacer()
                
                if notes.count >= 1 {
                    List {
                        ForEach(0..<notes.count, id: \.self) { i in
                            NavigationLink(destination: DetailView(note: notes[i], count: notes.count, index: i), label: {
                                HStack {
                                    Capsule()
                                        .frame(width: 4)
                                        .foregroundStyle(.accent)
                                    
                                    Text(notes[i].text)
                                        .lineLimit(lineCount)
                                        .padding(.leading, 5)
                                }
                            }) 
                        }
                        .onDelete(perform: { indexSet in
                            delete(offsets: indexSet)
                        })
                    }
                } else {
//               OPTION 1:     Default content available view with APPLE given lib
//                    ContentUnavailableView("No Notes found", image: "", description: Text("Please add some notes"))
                    
//                  OPTION 2:  Custom UI View with REDACTED Feature
//                    PlaceholderView()
//                        .redacted(reason: .placeholder)
//                    Option 3: your custom handling
                    Image(systemName: "note.text")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.gray)
                        .opacity(0.45)
                        .padding(25)
                }
            }
            .navigationTitle("Notes")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                load()
            })
        })
    }
}

#Preview {
    ContentView()
}
