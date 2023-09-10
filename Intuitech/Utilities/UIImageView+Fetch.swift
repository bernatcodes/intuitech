//
//  UIImageView+Fetch.swift
//  Intuitech
//
//  Created by Bernát Szabó on 2023. 09. 11..
//

import UIKit

extension UIImageView {
    func fetchImage(from url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
