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
    
    init(word: String, color: UIColor) {
        self.baseColor = color
        super.init(frame: .zero)
        self.text = word
        self.textAlignment = .center
        self.font = UIFont.boldSystemFont(ofSize: 16)
        
        self.textColor = .white
        self.backgroundColor = baseColor
        
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
              self.transform = self.isSelected ? CGAffineTransform(scaleX: 1.2, y: 1.2) : .identity
              self.backgroundColor = self.baseColor.withAlphaComponent(self.isSelected ? 1.0 : 0.8)
          }
      }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
