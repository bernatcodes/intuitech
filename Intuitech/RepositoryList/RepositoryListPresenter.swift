//
//  RepositoryListPresenter.swift
//  Intuitech
//
//  Created by Bernát Szabó on 2023. 09. 06..
//

import Foundation

final class RepositoryPresenter {
    // MARK: - Private properties
    private let coordinator: CoordinatorProtocol
    private let networkManager: NetworkProtocol
    private var currentQuery: String? = nil
    private var isCurrentlyFetchingData: Bool = false
    
    // MARK: - Public properties
    var repositories: [Repository] = []
    var currentPage: Int = .zero
    
    // MARK: - Managed view
    weak var view: RepositoryListViewProtocol?
    
    // MARK: - Init
    init(coordinator: CoordinatorProtocol, networkManager: NetworkProtocol) {
        self.coordinator = coordinator
        self.networkManager = networkManager
    }
}

// MARK: - Internal API
extension RepositoryPresenter: RepositoryPresenterProtocol {
    func searchRepositories(withQuery query: String, resetSearch: Bool) {
        if resetSearch {
            currentPage = .zero
            currentQuery = nil
        }
        
        if currentQuery != query || resetSearch {
            repositories = []
            view?.resetTableViewData()
        }
        
        guard !isCurrentlyFetchingData else { return }
        isCurrentlyFetchingData = true
        networkManager.fetchRepositories(with: query, page: currentPage) { [weak self] (repositories,
                                                                                        totalCount,
                                                                                        error) in
            guard let self = self else { return }
            if let error = error {
                self.repositories = []
                self.view?.displayError(error)
                self.currentQuery = nil
            } else if let repositories = repositories {
                let previousRepositoriesCount = self.repositories.count
                if self.currentQuery == query {
                    self.repositories.append(contentsOf: repositories)
                } else {
                    self.repositories = repositories
                }
                self.view?.displayRepositories(noMoreResult: previousRepositoriesCount == repositories.count || totalCount < Constants.defaultItemsPerPage)
                self.currentQuery = query
                self.currentPage += 1
            }
            self.isCurrentlyFetchingData = false
        }
    }
    
    func navigateToRepositoryDetail(of row: Int) {
        coordinator.showRepositoryDetail(repository: repositories[row])
    }
}

// MARK: - Constants
private enum Constants {
    static let defaultItemsPerPage = 30
}
