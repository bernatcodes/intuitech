//
//  RepositoryPresenterTests.swift
//  RepositoryPresenterTests
//
//  Created by Bernát Szabó on 2023. 09. 06..
//

import Nimble
import XCTest
@testable import Intuitech

final class RepositoryPresenterTests: XCTestCase {
    var coordinatorMock: CoordinatorMock!
    var networkManagerMock: NetworkManagerMock!
    var viewMock: RepositoryListViewMock!
    var sut: RepositoryPresenter!
    
    override func setUp() {
        super.setUp()
        coordinatorMock = CoordinatorMock()
        networkManagerMock = NetworkManagerMock()
        viewMock = RepositoryListViewMock()
    }

    override func tearDown() {
        sut = nil
        coordinatorMock = nil
        networkManagerMock = nil
        viewMock = nil
        super.tearDown()
    }

    func initSut() {
        let presenter = RepositoryPresenter(coordinator: coordinatorMock,
                                            networkManager: networkManagerMock)
        presenter.view = viewMock
        sut = presenter
    }
}

// MARK: - Tests
extension RepositoryPresenterTests {
    func testSuccessfulFetchShouldDisplayRepositories() {
        // Given
        let networkManager = NetworkManagerMock()
        networkManager.totalCount = 20
        networkManager.repositories = [.create(),
                                       .create(),
                                       .create()]
        
        // When
        networkManagerMock = networkManager
        initSut()
        sut.searchRepositories(withQuery: "query", resetSearch: false)
        
        // Then
        expect(self.viewMock.wasDisplayRepositoriesCalled).to(beTrue())
    }
    
    func testShouldResetSearch() {
        // Given
        let networkManager = NetworkManagerMock()
        networkManager.error = NSError(domain: "error", code: 1)
        
        // When
        networkManagerMock = networkManager
        initSut()
        sut.searchRepositories(withQuery: "query", resetSearch: true)
        
        // Then
        expect(self.viewMock.wasResetTableViewDataCalled).to(beTrue())
    }
    
    func testFirstPageFetch() {
        // Given
        let networkManager = NetworkManagerMock()
        networkManager.totalCount = 40
        networkManager.repositories = [.create(),
                                       .create(),
                                       .create()]
        
        // When
        networkManagerMock = networkManager
        initSut()
        sut.searchRepositories(withQuery: "query", resetSearch: false)
        
        // Then
        expect(self.sut.currentPage).to(equal(1))
    }
    
    func testMultiplePageFetches() {
        // Given
        let networkManager = NetworkManagerMock()
        networkManager.totalCount = 100
        networkManager.repositories = [.create(),
                                       .create(),
                                       .create()]
        
        // When
        networkManagerMock = networkManager
        initSut()
        sut.searchRepositories(withQuery: "query", resetSearch: false)
        sut.searchRepositories(withQuery: "query", resetSearch: false)
        sut.searchRepositories(withQuery: "query", resetSearch: false)
        
        // Then
        expect(self.sut.currentPage).to(equal(3))
    }
    
    func testFailedFetchShouldDisplayError() {
        // Given
        let networkManager = NetworkManagerMock()
        networkManager.error = NSError(domain: "error", code: 1)
        
        // When
        networkManagerMock = networkManager
        initSut()
        sut.searchRepositories(withQuery: "query", resetSearch: false)
        
        // Then
        expect(self.viewMock.wasDisplayErrorCalled).to(beTrue())
    }
    
    func testErrorShouldResetCurrentPage() {
        // Given
        let networkManager = NetworkManagerMock()
        networkManager.error = NSError(domain: "error", code: 1)
        
        // When
        networkManagerMock = networkManager
        initSut()
        sut.searchRepositories(withQuery: "query", resetSearch: false)
        
        // Then
        expect(self.viewMock.wasDisplayErrorCalled).to(beTrue())
        expect(self.sut.currentPage).to(equal(.zero))
    }
    
    func testSuccessfulFetchShouldStoreRepositories() {
        // Given
        let networkManager = NetworkManagerMock()
        networkManager.totalCount = 3
        networkManager.repositories = [.create(),
                                       .create(),
                                       .create()]
        
        // When
        networkManagerMock = networkManager
        initSut()
        sut.searchRepositories(withQuery: "query", resetSearch: false)
        
        // Then
        expect(self.sut.repositories.count).to(equal(3))
    }
    
    func testSuccessfulMultipleFetchesWithSameQueryShouldStoreRepositories() {
        // Given
        let networkManager = NetworkManagerMock()
        networkManager.totalCount = 3
        networkManager.repositories = [.create(),
                                       .create(),
                                       .create()]
        
        // When
        networkManagerMock = networkManager
        initSut()
        sut.searchRepositories(withQuery: "query", resetSearch: false)
        sut.searchRepositories(withQuery: "query", resetSearch: false)
        
        // Then
        expect(self.sut.repositories.count).to(equal(6))
    }
    
    func testSuccessfulMultipleFetchesWithDifferentQueryShouldOnlyStoreLastFetchRepositories() {
        // Given
        let networkManager = NetworkManagerMock()
        networkManager.totalCount = 3
        networkManager.repositories = [.create(),
                                       .create(),
                                       .create()]
        
        // When
        networkManagerMock = networkManager
        initSut()
        sut.searchRepositories(withQuery: "query", resetSearch: false)
        sut.searchRepositories(withQuery: "differentQuery", resetSearch: false)
        
        // Then
        expect(self.sut.repositories.count).to(equal(3))
    }
    
    func testNavigateToRepositoryDetail() {
        // Given
        let networkManager = NetworkManagerMock()
        networkManager.totalCount = 1
        networkManager.repositories = [.create()]
        
        // When
        networkManagerMock = networkManager
        initSut()
        sut.searchRepositories(withQuery: "query", resetSearch: false)
        sut.navigateToRepositoryDetail(of: .zero)
        
        // Then
        expect(self.coordinatorMock.wasShowRepositoryDetailCalled).to(beTrue())
    }
    
    // TODO: - Add more tests...
}
