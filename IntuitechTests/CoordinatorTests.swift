//
//  CoordinatorTests.swift
//  IntuitechTests
//
//  Created by Bernát Szabó on 2023. 09. 11..
//

import Nimble
import XCTest

@testable import Intuitech

final class Coordinatortests: XCTestCase {
    var navigationControllerMock: UINavigationController!
    var networkManagerMock: NetworkManagerMock!
    var viewMock: RepositoryListViewMock!
    var sut: Coordinator!
    
    override func setUp() {
        super.setUp()
        navigationControllerMock = UINavigationController()
        networkManagerMock = NetworkManagerMock()
        viewMock = RepositoryListViewMock()
    }

    override func tearDown() {
        sut = nil
        navigationControllerMock = nil
        networkManagerMock = nil
        viewMock = nil
        super.tearDown()
    }

    func initSut() {
        sut = Coordinator(navigationController: navigationControllerMock,
                          networkManager: networkManagerMock)
    }
    
    func testStart() {
        // When
        initSut()
        sut.start()
        
        // Then
        expect(self.listPresenter()).toNot(beNil())
    }
    
    func testShowRepositoryDetail() {
        // When
        initSut()
        sut.showRepositoryDetail(repository: .create())
        
        // Then
        expect(self.detailViewController()).toNot(beNil())
    }
    
    // MARK: - Helpers
    func listPresenter() -> RepositoryPresenter? {
        return (navigationControllerMock.topViewController as? RepositoryListViewController)?.presenter as? RepositoryPresenter
    }
    
    func detailViewController() -> RepositoryDetailViewController? {
        return (navigationControllerMock.topViewController as? RepositoryDetailViewController)
    }
}
