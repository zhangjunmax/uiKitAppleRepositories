//
//  Repository+Fixture.swift
//  uiKitAppleRepositoriesTests
//
//  Created by Jun Zhang on 2022/1/20.
//

import Foundation
@testable import uiKitAppleRepositories

extension Repository {

  static func fixture(
    name: String = "name",
    description: String = "description",
    createdAt: String = "2015-10-12T22:33:18Z",
    stargazersCount: Int = 1000
  ) -> Repository {
      Repository(name: name, description: description, createdAt: createdAt, stargazersCount: stargazersCount)
  }
}
