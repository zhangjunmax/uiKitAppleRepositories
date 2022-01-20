//
//  ExtensionTest.swift
//  uiKitAppleRepositoriesTests
//
//  Created by Jun Zhang on 2022/1/20.
//

import Foundation
import XCTest
@testable import uiKitAppleRepositories

class ExtensionTest: XCTestCase {

    func testRequestGeneration() {
        // given
        let createDate = "2022-01-20T22:33:18Z"

        // when
        let shortDateString = createDate.shortDateString

        // then
        XCTAssertEqual(shortDateString, "2022-01-20")
    }
}
