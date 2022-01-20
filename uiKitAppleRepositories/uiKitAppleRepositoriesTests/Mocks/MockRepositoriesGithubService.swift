//
//  MockGithubService.swift
//  uiKitAppleRepositoriesTests
//
//  Created by Jun Zhang on 2022/1/20.
//

import Foundation
import Combine
@testable import uiKitAppleRepositories

final class MockRepositoriesGithubService: RepositoriesServiceProtocol {
    var result: Result<[Repository], Error> = .success([])

    func fetchRepositories(organisation: String, page: Int, perPage: Int) -> AnyPublisher<[Repository], Error>? {
        return result.publisher
            // Use a delay to simulate the real world async behavior
            .delay(for: 0.1, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
