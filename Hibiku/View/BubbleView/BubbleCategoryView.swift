//
//  BubbleCategoryView.swift
//  Hibiku
//
//  Created by 神林沙希 on 2025/06/01.
//

import SwiftUI

struct BubbleCategoryView: UIViewControllerRepresentable {
    let items: [Onomatopoeia]

    func makeUIViewController(context: Context) -> BubbleViewController {
        let vc = BubbleViewController()
        vc.onomatopoeiaList = items
        return vc
    }

    func updateUIViewController(_ uiViewController: BubbleViewController, context: Context) {}

}


