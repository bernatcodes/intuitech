//
//  UIColor+Invert.swift
//  Intuitech
//
//  Created by Bernát Szabó on 2023. 09. 11..
//

import UIKit

extension UIColor {
    var inverted: UIColor {
        var r: CGFloat = .zero, g: CGFloat = .zero, b: CGFloat = .zero, a: CGFloat = .zero
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return UIColor(red: (1 - r), green: (1 - g), blue: (1 - b), alpha: a)
    }
}
