//
//  BubbleCategoryView.swift
//  Hibiku
//
//  Created by 神林沙希 on 2025/06/01.
//

import SwiftUI

struct BubbleCategoryView: UIViewControllerRepresentable {
    let items: [Onomatopoeia]
//    @Binding var selectedWord: String?
//    @Binding var selectedColor: UIColor?

    func makeUIViewController(context: Context) -> BubbleViewController {
        let vc = BubbleViewController()
        vc.onomatopoeiaList = items
//        vc.delegate = context.coordinator
        return vc
    }

    func updateUIViewController(_ uiViewController: BubbleViewController, context: Context) {}

//    func makeCoordinator() -> Coordinator {
//        Coordinator(parent: self)
//    }
//
//    class Coordinator: NSObject, BubbleSelectionDelegate {
//        let parent: BubbleCategoryView
//
//        init(parent: BubbleCategoryView) {
//            self.parent = parent
//        }
//
//        func didSelect(word: String?, color: UIColor?) {
//            parent.selectedWord = word
//            parent.selectedColor = color
//        }
//    }
}


