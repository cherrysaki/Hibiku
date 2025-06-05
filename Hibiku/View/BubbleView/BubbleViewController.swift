//
//  BubbleContainerView.swift
//  Hibiku
//
//  Created by 神林沙希 on 2025/06/01.
//

import Foundation
import SwiftUI
import UIKit

protocol BubbleViewControllerDelegate: AnyObject {
    func didSelectBubble(word: String?, color: UIColor?)
}

class BubbleViewController: UIViewController {

    weak var delegate: BubbleViewControllerDelegate?

    var placedBubbles: [BubbleView] = []
    var onomatopoeiaList: [Onomatopoeia] = []
    var selectedBubble: BubbleView?  // 現在選択中のバブル

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createAndPlaceBubbles(onomatopoeiaList)
    }

    func createAndPlaceBubbles(_ onomas: [Onomatopoeia]) {
        let center = CGPoint(x: view.bounds.midX, y: view.bounds.midY - 200)
        let maxAttempts = 1000
        placedBubbles = []

        for item in onomas {
            let baseColor = UIColor(hex: item.colorHex)
            let bubbleColor = baseColor.slightlyVaried(by: 0.04)
            let bubble = BubbleView(
                word: item.word,
                baseColor: baseColor,
                displayColor: bubbleColor
            )
            //タップ可能にする
            bubble.addGestureRecognizer(
                UITapGestureRecognizer(
                    target: self,
                    action: #selector(handleBubbleTap(_:))
                )
            )

            var placed = false
            var attempts = 0

            while !placed && attempts < maxAttempts {
                let angle = CGFloat.random(in: 0...(2 * .pi))

                let diameter = bubble.bounds.width
                let maxDistance =
                    min(view.bounds.width, view.bounds.height) / 2 - diameter
                    / 2 - 20
                let distance = CGFloat.random(in: 20...max(maxDistance, 20))

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

    //バブルをタップした時の選択状態を管理する
    @objc func handleBubbleTap(_ sender: UITapGestureRecognizer) {
        guard let tappedBubble = sender.view as? BubbleView else { return }

        if selectedBubble == tappedBubble {
            // 同じバブルを再度タップ → 選択解除
            tappedBubble.isSelected = false
            selectedBubble = nil
            delegate?.didSelectBubble(word: nil, color: nil)
        } else {
            // 前の選択を解除
            selectedBubble?.isSelected = false
            // 新しいバブルを選択
            tappedBubble.isSelected = true
            selectedBubble = tappedBubble
            if let word = tappedBubble.text {
                delegate?.didSelectBubble(
                    word: word,
                    color: tappedBubble.baseColor
                )
                print(tappedBubble.baseColor.toHexString())
            } else {
                delegate?.didSelectBubble(word: nil, color: nil)
            }

        }
    }

    func isOverlapping(bubble: UIView) -> Bool {
        for existing in placedBubbles {
            let d = hypot(
                bubble.center.x - existing.center.x,
                bubble.center.y - existing.center.y
            )
            if d < (bubble.bounds.width + existing.bounds.width) / 2 - 10 {
                return true
            }
        }
        return false
    }
}
