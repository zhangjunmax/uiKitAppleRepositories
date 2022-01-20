//
//  EndpointTests.swift
//  uiKitAppleRepositoriesTests
//
//  Created by Jun Zhang on 2022/1/20.
//

import Foundation
import XCTest
@testable import uiKitAppleRepositories

class EndpointTests: XCTestCase {

    func testRequestGeneration() {
        // given
        let endpoint = Endpoint.repos(organisation: "apple", page: 2, perPage: 22)

        // when
        let url = endpoint.findURL()

        // then
        XCTAssertEqual(url, URL(string: "https://api.github.com/orgs/apple/repos?type=owner&page=2&per_page=22"))
    }
}
