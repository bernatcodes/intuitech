//
//  OutputDateFormatter.swift
//  Intuitech
//
//  Created by Bernát Szabó on 2023. 09. 11..
//

import Foundation

final class OutputDateFormatter: DateFormatter {
    // MARK: - Init
    override init() {
        super.init()
        locale = .current
        dateFormat = Constants.outputDateFormat
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: - Constants
private enum Constants {
    static let outputDateFormat: String = "yyyy. MM. dd. HH:mm"
}
