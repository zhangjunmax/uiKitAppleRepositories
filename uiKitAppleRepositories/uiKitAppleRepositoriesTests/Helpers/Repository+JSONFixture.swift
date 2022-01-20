//
//  Repository+JSONFixture.swift
//  uiKitAppleRepositoriesTests
//
//  Created by Jun Zhang on 2022/1/20.
//

import Foundation
@testable import uiKitAppleRepositories

extension Repository {

    static func jsonFixture(
        name: String = Repository.fixture().name,
        description: String = Repository.fixture().description ?? "",
        createdAt: String = Repository.fixture().createdAt,
        stargazersCount: Int = Repository.fixture().stargazersCount
    ) -> String {
        return """
{
    "name": "\(name)",
    "description": "\(description)",
    "created_at": "\(createdAt)",
    "stargazers_count": \(stargazersCount)
}
"""
    }
}
