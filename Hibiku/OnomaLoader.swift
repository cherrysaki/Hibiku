//
//  OnomatopoeiaLoader.swift
//  Hibiku
//
//  Created by 神林沙希 on 2025/06/01.
//

import Foundation

class OnomaLoader: ObservableObject {
    @Published var onomatopoeiaList: [Onomatopoeia] = []

    init() {
        load()
    }

    func load() {
        guard let url = Bundle.main.url(forResource: "onomatopoeia", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let decoded = try? JSONDecoder().decode([Onomatopoeia].self, from: data)
        else {
            return
        }
        self.onomatopoeiaList = decoded
    }
}
