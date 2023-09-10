//
//  NetworkManager.swift
//  Intuitech
//
//  Created by Bernát Szabó on 2023. 09. 09..
//

import Foundation

protocol NetworkProtocol {
    func fetchRepositories(with query: String, page: Int, completion: @escaping ([Repository]?, Int, Error?) -> Void)
}

final class NetworkManager: NetworkProtocol {
    // MARK: - Private
    private let inputDateFormatter = InputDateFormatter()
    private let outputDateFormatter = OutputDateFormatter()
    private let commonGitHubError: NSError = NSError(domain: Constants.commonError, code: .zero, userInfo: nil)
    
    // MARK: - Fetch repositories with query
    func fetchRepositories(with query: String, page: Int, completion: @escaping ([Repository]?, Int, Error?) -> Void) {
        var components = URLComponents(string: Constants.baseUrl)!
        components.queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "page", value: "\(page)")
        ]
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForResource = Constants.timeoutInterval
        let session = URLSession(configuration: sessionConfig)
        let task = session.dataTask(with: components.url!) { [weak self] (data, response, error) in
            if let error = error {
                completion(nil, .zero, error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == Constants.status200 else {
                completion(nil, .zero, self?.commonGitHubError)
                return
            }
            
            guard let data = data else {
                completion(nil, .zero, self?.commonGitHubError)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                let totalCount = json?["total_count"] as? Int ?? .zero
                if let items = json?["items"] as? [[String: Any]] {
                    let repositories = items.compactMap { item in
                        if let name = item["name"] as? String,
                           let description = item["description"] as? String,
                           let stars = item["stargazers_count"] as? Int,
                           let lastUpdated = item["updated_at"] as? String,
                           let owner = item["owner"] as? [String: Any],
                           let ownerName = owner["login"] as? String,
                           let ownerAvatarUrl = owner["avatar_url"] as? String,
                           let ownerProfileUrl = owner["html_url"] as? String,
                           let repositoryUrl = item["html_url"] as? String,
                           let forks = item["forks_count"] as? Int,
                           let createdAt = item["created_at"] as? String {
                             
                            let inputLastUpdatedDate = self?.inputDateFormatter.date(from: lastUpdated)
                            let outputLastUpdatedDate = inputLastUpdatedDate != nil ?
                            self?.outputDateFormatter.string(from: inputLastUpdatedDate!) : nil
                            
                            let inputCreatedAtDate = self?.inputDateFormatter.date(from: createdAt)
                            let outputCreatedAtDate = inputCreatedAtDate != nil ?
                            self?.outputDateFormatter.string(from: inputCreatedAtDate!) : nil
                            
                            return Repository(ownerName: ownerName,
                                              ownerAvatarUrl: URL(string: ownerAvatarUrl),
                                              ownerProfileUrl: URL(string: ownerProfileUrl),
                                              name: name,
                                              description: description,
                                              stars: stars,
                                              forks: forks,
                                              createdAt: outputCreatedAtDate,
                                              lastUpdated: outputLastUpdatedDate,
                                              url: URL(string: repositoryUrl))
                        }
                        return nil
                    }
                    completion(repositories, totalCount, nil)
                } else {
                    completion(nil, .zero, self?.commonGitHubError)
                }
            } catch {
                completion(nil, .zero, error)
            }
        }
        task.resume()
    }
}

// MARK: Constants
private enum Constants {
    static let baseUrl = "https://api.github.com/search/repositories"
    static let commonError = "GitHubAPIError"
    static let timeoutInterval = 10.0
    static let status200 = 200
}
