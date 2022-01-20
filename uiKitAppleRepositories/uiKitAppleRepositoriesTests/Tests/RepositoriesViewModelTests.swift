//
//  GithubServiceTests.swift
//  uiKitAppleRepositoriesTests
//
//  Created by Jun Zhang on 2022/1/20.
//

import Foundation
import Combine
import XCTest
@testable import uiKitAppleRepositories

class RepositoriesViewModelTests: XCTestCase {
    private var mockRepositoriesGithubService: MockRepositoriesGithubService!
    private var viewModel: RepositoriesViewModel!
    private var cancellables: Set<AnyCancellable> = []

    override func setUpWithError() throws {
        mockRepositoriesGithubService = MockRepositoriesGithubService()
        viewModel = RepositoriesViewModel(repositoriesService: mockRepositoriesGithubService)
    }

    override func tearDownWithError() throws {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        mockRepositoriesGithubService = nil
        viewModel = nil
    }


    func testWhenFetchingSucceedsEmpty() throws {
        // given
        mockRepositoriesGithubService.result = .success([])

        // when
        viewModel.fetchAllAppleRepositories()

        // then
        viewModel.$allRepositories
            .dropFirst()
            .sink { XCTAssertEqual($0, []) }
            .store(in: &self.cancellables)
    }

    func testWhenFetchingSucceedsShouldUpdateRepositories() {
        // given
        mockRepositoriesGithubService.result = .success([Repository.fixture()])

        // when
        viewModel.fetchAllAppleRepositories()

        // then
        viewModel.$allRepositories
            .dropFirst()
            .sink { XCTAssertEqual($0, [Repository.fixture()]) }
            .store(in: &self.cancellables)

        viewModel.$state
            .dropFirst()
            .sink { XCTAssertEqual($0, .finishedLoading) }
            .store(in: &self.cancellables)
    }

    func testWhenFetchingFailsShouldUpdateStateWithError() {
        // given
        mockRepositoriesGithubService.result = .failure(RequestError.repositoriesFetch)

        // when
        viewModel.fetchAllAppleRepositories()

        // then
        viewModel.$allRepositories
            .dropFirst()
            .sink { XCTAssert($0.isEmpty) }
            .store(in: &self.cancellables)

        viewModel.$state
            .dropFirst()
            .sink { XCTAssertEqual($0, .error(.repositoriesFetch)) }
            .store(in: &self.cancellables)
    }
    
    func testFetchingAppleRepositories() {
        let githubRepositoriesService = GithubRepositoriesService()

        // given
        // Declaring local variables that we'll be able to write
        // our output to, as well as an expectation that we'll
        // use to await our asynchronous result:
        var repositories = [Repository]()
        var error: Error?
        let expectation = expectation(description: "fetching apple repositories")

        // when
        githubRepositoriesService.fetchRepositories(organisation: Constants.API.githubRepositoryOrganisationApple, page: 1, perPage: Constants.API.githubRepositoriesPerPage)?
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let encounteredError):
                    error = encounteredError
                }

                expectation.fulfill()
            }, receiveValue: { value in
                repositories = value
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 10)

        // then
        XCTAssertNil(error)
        XCTAssertEqual(repositories.count, Constants.API.githubRepositoriesPerPage)
    }
}
