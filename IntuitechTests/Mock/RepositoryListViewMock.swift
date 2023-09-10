//
//  RepositoryListViewMock.swift
//  IntuitechTests
//
//  Created by Bernát Szabó on 2023. 09. 11..
//

@testable import Intuitech

final class RepositoryListViewMock: RepositoryListViewProtocol {
    var wasDisplayRepositoriesCalled = false
    var wasDisplayErrorCalled = false
    var wasResetTableViewDataCalled = false
    
    func displayRepositories(noMoreResult: Bool) {
        wasDisplayRepositoriesCalled = true
    }
    
    func displayError(_ error: Error) {
        wasDisplayErrorCalled = true
    }
    
    func resetTableViewData() {
        wasResetTableViewDataCalled = true
    }
}
