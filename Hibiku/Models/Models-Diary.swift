//
//  Models-Diary.swift
//  Hibiku
//
//  Created by 神林沙希 on 2025/06/04.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class Diary{
    let date: Date
    var onomaWord: String
    var onomaColorHex: String
    var content: String
    var wavePath: [Float]

    init(onomaWord: String, onomaColor: UIColor, content: String, wavePath: [Float]) {
        date = Date()
        self.onomaWord = onomaWord
        self.onomaColorHex = onomaColor.toHexString() 
        self.content = content
        self.wavePath = wavePath
       }
}
