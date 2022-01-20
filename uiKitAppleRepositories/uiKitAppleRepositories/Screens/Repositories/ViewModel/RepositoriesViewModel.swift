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
    private let repositoriesService: RepositoriesServiceProtocol
    private var cancellables: Set<AnyCancellable> = []

    @Published private(set) var allRepositories: [Repository] = []
    @Published private(set) var state: RemoteContentLoadingState = .loading

    var tempRepositories: [Repository] = []

    init(repositoriesService: RepositoriesServiceProtocol = GithubRepositoriesService()) {
        self.repositoriesService = repositoriesService
    }

    func fetchRecursiveRepositories(organisation: String, page: Int, perPage: Int) {
        logger.info("fetchRecursiveRepositories, organisation: \(organisation), page: \(page), perPage: \(perPage)")

        state = .loading

        repositoriesService.fetchRepositories(organisation: organisation, page: page, perPage: perPage)?
            .receive(on: DispatchQueue.main)
            .sink { completion in
                logger.info("fetchAllRepositories end")

                switch completion {
                case .failure(let error):
                    logger.info("fetchAllRepositories, error: \(error.localizedDescription)")

                    self.state = .error(.repositoriesFetch)

                case .finished:
                    self.state = .finishedLoading
                }
            } receiveValue: { [weak self] repositories in
                logger.info("fetchAllRepositories, receiveValue, repositories.count: \(repositories.count)")

                if repositories.count > 0 {
                    self?.tempRepositories.append(contentsOf: repositories)
                }

                //wenn current items count small as perPage -> finish fetch
                if repositories.count < perPage  {
                    self?.allRepositories = (self?.tempRepositories.sorted{$0.stargazersCount > $1.stargazersCount})!

                } else {
                    self?.fetchRecursiveRepositories(organisation: organisation, page: page + 1, perPage: perPage)
                }
            }
            .store(in: &cancellables)
    }

//    Repositories from apple need to be sorted by stargazersCount, but the github api now only supports sorting by created, updated, pushed, full_name (https://docs.github.com/en/rest/reference/repos). So the solution here is to get all the repositories recursively and then sort them all
    func fetchAllAppleRepositories() {
        logger.info("fetchAllAppleRepositories")

        fetchRecursiveRepositories(organisation: Constants.API.githubRepositoryOrganisationApple, page: 1, perPage: Constants.API.githubRepositoriesPerPage)
    }
}
