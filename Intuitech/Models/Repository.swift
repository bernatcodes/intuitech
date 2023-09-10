//
//  Repository.swift
//  Intuitech
//
//  Created by Bernát Szabó on 2023. 09. 06..
//

import Foundation

struct Repository {
    let ownerName: String
    let ownerAvatarUrl: URL?
    let ownerProfileUrl: URL?
    let name: String
    let description: String?
    let stars: Int
    let forks: Int
    let createdAt: String?
    let lastUpdated: String?
    let url: URL?
}
