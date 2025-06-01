//
//  BubbleView.swift
//  Hibiku
//
//  Created by 神林沙希 on 2025/06/01.
//

import Foundation
import UIKit

class BubbleView: UILabel {
    init(word: String, color: UIColor) {
        super.init(frame: .zero)
        self.text = word
        self.textAlignment = .center
        self.font = UIFont.boldSystemFont(ofSize: 16)
        self.textColor = .white
        self.backgroundColor = color
        self.sizeToFit()
        let diameter = max(self.bounds.width, self.bounds.height) + 30
        self.frame.size = CGSize(width: diameter, height: diameter)
        self.layer.cornerRadius = diameter / 2
        self.clipsToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
