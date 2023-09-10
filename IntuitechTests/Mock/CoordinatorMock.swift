//
//  CoordinatorMock.swift
//  IntuitechTests
//
//  Created by Bernát Szabó on 2023. 09. 11..
//

import UIKit

@testable import Intuitech

final class CoordinatorMock: CoordinatorProtocol {
    var navigationController: UINavigationController
    var wasStartCalled = false
    var wasShowRepositoryDetailCalled = false
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    func start() {
        wasStartCalled = true
    }
    
    func showRepositoryDetail(repository: Intuitech.Repository) {
        wasShowRepositoryDetailCalled = true
    }
}
