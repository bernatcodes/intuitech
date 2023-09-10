//
//  String+Shorted.swift
//  Intuitech
//
//  Created by Bernát Szabó on 2023. 09. 10..
//

extension String {
    func shortened(to symbols: Int) -> String {
        guard self.count > symbols else {
            return self
        }
        return self.prefix(symbols) + "..."
    }
}
