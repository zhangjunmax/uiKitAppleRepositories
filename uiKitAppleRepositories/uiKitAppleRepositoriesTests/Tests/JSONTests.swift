//
//  JSONTests.swift
//  uiKitAppleRepositoriesTests
//
//  Created by Jun Zhang on 2022/1/20.
//

import Foundation
import XCTest
@testable import uiKitAppleRepositories

class JSONTests: XCTestCase {

    func testWhenDecodedFromJSONData() throws {
        // given
        let json = Repository.jsonFixture()
        let data = try XCTUnwrap(json.data(using: .utf8))

        // when
        let item = try JSONDecoder().decode(Repository.self, from: data)

        XCTAssertEqual(item.name, Repository.fixture().name)
        XCTAssertEqual(item.description, Repository.fixture().description)
        XCTAssertEqual(item.createdAt, Repository.fixture().createdAt)
        XCTAssertEqual(item.stargazersCount, Repository.fixture().stargazersCount)
    }

    func testWhenDecodingFromJSONDataDoesNotThrow() throws {
        // given
        let json = Repository.jsonFixture()

        // when
        let data = try XCTUnwrap(json.data(using: .utf8))

        // then
        XCTAssertNoThrow(try JSONDecoder().decode(Repository.self, from: data))
    }
}
