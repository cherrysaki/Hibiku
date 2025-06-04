//
//  Models:Onomatopoeia.swift
//  Hibiku
//
//  Created by 神林沙希 on 2025/05/31.
//

import Foundation
import SwiftUI

struct Onomatopoeia: Identifiable, Codable {
    let id: UUID
    let word: String
    let category: String
    let colorHex: String
}
