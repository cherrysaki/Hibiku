//
//  BubbleCategoryView.swift
//  Hibiku
//
//  Created by 神林沙希 on 2025/06/01.
//

import SwiftUI

struct BubbleCategoryView: UIViewControllerRepresentable {
    @Binding var selectedWord: String?
    @Binding var selectedColor: UIColor?
    let items: [Onomatopoeia]
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> BubbleViewController {
        let vc = BubbleViewController()
        vc.onomatopoeiaList = items
        vc.delegate = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ uiViewController: BubbleViewController, context: Context) {}
    
    class Coordinator: NSObject, BubbleViewControllerDelegate {
        var parent: BubbleCategoryView
        
        init(_ parent: BubbleCategoryView) {
            self.parent = parent
        }
        
        func didSelectBubble(word: String?, color: UIColor?) {
            parent.selectedWord = word
            parent.selectedColor = color
        }
    }
}


