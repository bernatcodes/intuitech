//
//  InputDateFormatter.swift
//  Intuitech
//
//  Created by Bernát Szabó on 2023. 09. 11..
//

import Foundation

final class InputDateFormatter: DateFormatter {
    // MARK: - Init
    override init() {
        super.init()
        dateFormat = Constants.inputDateFormat
        timeZone = TimeZone(identifier: Constants.timeZone)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: - Constants
private enum Constants {
    static let timeZone: String = "UTC"
    static let inputDateFormat: String = "yyyy-MM-dd'T'HH:mm:SSSZ"
}
