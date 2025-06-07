//
//  Diary+ColorExtensions.swift
//  Hibiku
//
//  Created by 神林沙希 on 2025/06/07.
//
import SwiftUI
import UIKit

//複数日記のオノマトペの平均色を取ってくる！
extension Array where Element == Diary {
    func averageColor(for date: Date) -> Color? {
        let entries = self.filter {
            Calendar.current.isDate($0.date, inSameDayAs: date)
        }
        guard !entries.isEmpty else { return nil }

        var totalR: CGFloat = 0
        var totalG: CGFloat = 0
        var totalB: CGFloat = 0
        var count: CGFloat = 0
        for entry in entries {
            let uiColor = UIColor(hex: entry.onomaColorHex)
            var r: CGFloat = 0
            var g: CGFloat = 0
            var b: CGFloat = 0
            var a: CGFloat = 0
            if uiColor.getRed(&r, green: &g, blue: &b, alpha: &a) {
                totalR += r
                totalG += g
                totalB += b
                count += 1
            }
        }

        guard count > 0 else { return nil }
        return Color(
            UIColor(
                red: totalR / count,
                green: totalG / count,
                blue: totalB / count,
                alpha: 1.0
            )
        )
    }
}
