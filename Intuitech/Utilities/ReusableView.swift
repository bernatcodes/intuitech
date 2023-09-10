//
//  Utilities.swift
//  Intuitech
//
//  Created by Bernát Szabó on 2023. 09. 10..
//

import UIKit

protocol ReusableView {
    static var reuseKey: String { get }
}

extension ReusableView {
    static var reuseKey: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView {}
