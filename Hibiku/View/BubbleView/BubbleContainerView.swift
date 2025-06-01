//
//  BubbleContainerView.swift
//  Hibiku
//
//  Created by 神林沙希 on 2025/06/01.
//

import Foundation
import UIKit
import SwiftUI

class BubbleViewController: UIViewController {
    var bubbles: [BubbleView] = []
    var placedBubbles: [UIView] = []
    var onomatopoeiaList: [Onomatopoeia] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createAndPlaceBubbles(onomatopoeiaList)
    }

    func createAndPlaceBubbles(_ onomas: [Onomatopoeia]) {
        let center = view.center
        let maxAttempts = 1000
        placedBubbles = []

        for item in onomas {
            let color = UIColor(hex: item.colorHex)
            let bubble = BubbleView(word: item.word, color: color)

            var placed = false
            var attempts = 0

            while !placed && attempts < maxAttempts {
                let angle = CGFloat.random(in: 0...(2 * .pi))
                let distance = CGFloat.random(in: 40...120)
                let x = center.x + cos(angle) * distance
                let y = center.y + sin(angle) * distance
                bubble.center = CGPoint(x: x, y: y)
                if !isOverlapping(bubble: bubble) {
                    view.addSubview(bubble)
                    placedBubbles.append(bubble)
                    placed = true
                }
                attempts += 1
            }
        }
    }

    func isOverlapping(bubble: UIView) -> Bool {
        for existing in placedBubbles {
            let d = hypot(bubble.center.x - existing.center.x, bubble.center.y - existing.center.y)
            if d < (bubble.bounds.width + existing.bounds.width) / 2 - 5 {
                return true
            }
        }
        return false
    }
}

