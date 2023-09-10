//
//  Repository+Factory.swift
//  IntuitechTests
//
//  Created by Bernát Szabó on 2023. 09. 11..
//

import Foundation

@testable import Intuitech

extension Repository {
    static func create(ownerName: String = "ownerName",
                       ownerAvatarUrl: URL? = URL(string: "https://www.google.hu/?client=safari"),
                       ownerProfileUrl: URL? = URL(string: "https://www.google.hu/?client=safari"),
                       name: String = "name",
                       description: String = "description",
                       stars: Int = 50,
                       forks: Int = 20,
                       createdAt: String? = OutputDateFormatter().string(from: .now),
                       lastUpdated: String = OutputDateFormatter().string(from: .now),
                       url: URL? = URL(string: "https://www.google.hu/?client=safari")) -> Repository {
        Repository(ownerName: ownerName,
                   ownerAvatarUrl: ownerAvatarUrl,
                   ownerProfileUrl: ownerProfileUrl,
                   name: name,
                   description: description,
                   stars: stars,
                   forks: forks,
                   createdAt: createdAt,
                   lastUpdated: lastUpdated,
                   url: url)
    }
}
