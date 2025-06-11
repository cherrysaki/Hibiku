//
//  BubbleView.swift
//  Hibiku
//
//  Created by 神林沙希 on 2025/06/01.
//

import Foundation
import UIKit

class BubbleView: UILabel {
    var isSelected: Bool = false {
        didSet {
            updateAppearance()
        }
    }
    
    let baseColor: UIColor
    let displayColor: UIColor
    
    init(word: String, baseColor: UIColor, displayColor: UIColor) {
        self.baseColor = baseColor
        self.displayColor = displayColor
        super.init(frame: .zero)
        self.text = word
        self.textAlignment = .center
        self.font = UIFont(name: "ZenMaruGothic-Regular", size: 16)
        
        self.textColor = UIColor(hex: "6E6869")
        self.backgroundColor = displayColor
        
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.isUserInteractionEnabled = true
        
        self.sizeToFit()
        let diameter = max(self.bounds.width, self.bounds.height) + 30
        self.frame.size = CGSize(width: diameter, height: diameter)
        self.layer.cornerRadius = diameter / 2
    }
    
    func updateAppearance() {
        UIView.animate(withDuration: 0.2) {
            self.transform = self.isSelected
            ? CGAffineTransform(scaleX: 1.2, y: 1.2) : .identity
            self.backgroundColor = self.displayColor.withAlphaComponent(
                self.isSelected == true ? 1.0 : 0.8
            )
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
