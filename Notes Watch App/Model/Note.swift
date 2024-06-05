//
//  Note.swift
//  Notes Watch App
//
//  Created by Sravanthi Chinthireddy on 05/06/24.
//

import Foundation

struct Note: Codable, Identifiable {
    let id: UUID
    let text: String
}
