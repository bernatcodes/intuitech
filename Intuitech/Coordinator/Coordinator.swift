//
//  Coordinator.swift
//  Intuitech
//
//  Created by Bernát Szabó on 2023. 09. 06..
//

import UIKit

protocol CoordinatorProtocol {
    var navigationController: UINavigationController { get }
    func start()
    func showRepositoryDetail(repository: Repository)
}

final class Coordinator: CoordinatorProtocol {
    // MARK: - Internal properties
    let navigationController: UINavigationController
    
    // MARK: - Private properties
    private let networkManager: NetworkProtocol
    
    // MARK: - Init
    init(navigationController: UINavigationController, networkManager: NetworkProtocol) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.prefersLargeTitles = true
        self.networkManager = networkManager
    }
    
    func start() {
        let presenter = RepositoryPresenter(coordinator: self, networkManager: networkManager)
        let repositoryListViewController = RepositoryListViewController(presenter: presenter)
        presenter.view = repositoryListViewController
        
        navigationController.pushViewController(repositoryListViewController, animated: false)
    }
    
    func showRepositoryDetail(repository: Repository) {
        let detailViewController = RepositoryDetailViewController(repository: repository)
        
        navigationController.pushViewController(detailViewController, animated: true)
    }
}

