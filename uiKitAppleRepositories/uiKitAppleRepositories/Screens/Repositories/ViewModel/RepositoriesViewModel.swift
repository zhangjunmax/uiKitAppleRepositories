//
//  RepositoriesViewModel.swift
//  uiKitAppleRepositories
//
//  Created by Jun Zhang on 2022/1/20.
//

import Foundation
import Combine

enum RequestError: Error, Equatable {
    case repositoriesFetch
}

enum RemoteContentLoadingState: Equatable {
    case loading
    case finishedLoading
    case error(RequestError)
}

class RepositoriesViewModel {

    var pageSize = 100

    private let githubService: GithubServiceProtocol
    private var cancellables: Set<AnyCancellable> = []

    @Published private(set) var allRepositories: [Repository] = []
    @Published private(set) var state: RemoteContentLoadingState = .loading

    var tempRepositories: [Repository] = []

    init(githubService: GithubServiceProtocol = GithubService()) {
        print("init githubService: \(githubService)")
        self.githubService = githubService
    }

    private func tryAddRepositories(repositories: [Repository]) -> Bool {

        if repositories.count > 0 {
            tempRepositories.append(contentsOf: repositories)
        }

        if repositories.count < pageSize  {
            allRepositories = tempRepositories.sorted{$0.stargazersCount > $1.stargazersCount}

            print("end allRepositories.count: \(allRepositories.count)")
            print("end allRepositories.first?.name: \(allRepositories.first?.name)")
            return false
        } else {
            return true
        }
    }

    func fetchAllRepositories(organisation: String, page: Int, perPage: Int) {
        print("fetchAllRepositories, page: \(page), githubService: \(githubService)")

        state = .loading

        githubService.fetchRepositories(organisation: organisation, page: page, perPage: perPage)?
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("fetchAllRepositories, completion22: \(completion)")

                switch completion {
                case .failure(let error):
                    print("fetchAllRepositories, error: \(error)")

                    self.state = .error(.repositoriesFetch)

                case .finished:
                    self.state = .finishedLoading
                }
            } receiveValue: { [weak self] repositories in
                print("fetchAllRepositories, receiveValue, repositories.count: \(repositories.count)")

                if self?.tryAddRepositories(repositories: repositories) ?? false {
                    self?.fetchAllRepositories(organisation: organisation, page: page + 1, perPage: perPage)
                } else {

                }

            }
            .store(in: &cancellables)
    }

    func fetchAllAppleRepositories() {
        print("fetchAllAppleRepositories")

        fetchAllRepositories(organisation: "apple", page: 1, perPage: 100)
    }

//    func retrySearch() {
//        fetchPlayers(with: currentSearchQuery)
//    }
}
