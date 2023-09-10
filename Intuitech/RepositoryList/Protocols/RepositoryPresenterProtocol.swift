//
//  RepositoryPresenterProtocol.swift
//  Intuitech
//
//  Created by Bernát Szabó on 2023. 09. 10..
//

protocol RepositoryPresenterProtocol {
    var view: RepositoryListViewProtocol? { get set }
    var repositories: [Repository] { get }
    var currentPage: Int { get }
    func searchRepositories(withQuery query: String, resetSearch: Bool)
    func navigateToRepositoryDetail(of row: Int)
}
