//
//  GithubService.swift
//  uiKitAppleRepositories
//
//  Created by Jun Zhang on 2022/1/20.
//

import Foundation
import Combine

protocol GithubServiceProtocol {
    func fetchRepositories(organisation: String, page: Int, perPage: Int) -> AnyPublisher<[Repository], Error>?
}

class GithubService: GithubServiceProtocol {
    let networker: NetworkerProtocol

    init(networker: NetworkerProtocol = Networker()) {
        self.networker = networker
    }

    func fetchRepositories(organisation: String, page: Int, perPage: Int) -> AnyPublisher<[Repository], Error>? {
        print("fetchRepositories, organisation: \(organisation), page: \(page), perPage: \(perPage)")

        let endpoint = Endpoint.repos(organisation: organisation, page: page, perPage: perPage)

        return networker.fetch(
            type: [Repository].self,
            url: endpoint.findURL(),
            httpMethod: endpoint.httpMethod
        )
    }
}
