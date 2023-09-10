//
//  RepositoryListViewProtocol.swift
//  Intuitech
//
//  Created by Bernát Szabó on 2023. 09. 06..
//

protocol RepositoryListViewProtocol: AnyObject {
    func displayRepositories(noMoreResult: Bool)
    func displayError(_ error: Error)
    func resetTableViewData()
}
