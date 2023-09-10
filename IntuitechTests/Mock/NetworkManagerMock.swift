//
//  NetworkManagerMock.swift
//  IntuitechTests
//
//  Created by Bernát Szabó on 2023. 09. 11..
//

@testable import Intuitech

class NetworkManagerMock: NetworkProtocol {
    var repositories: [Repository]?
    var totalCount: Int = .zero
    var error: Error?
    
    func fetchRepositories(with query: String, page: Int, completion: @escaping ([Repository]?, Int, Error?) -> Void) {
        if let error = error {
            completion(nil, .zero, error)
        } else {
            completion(repositories, totalCount, nil)
        }
    }
}
