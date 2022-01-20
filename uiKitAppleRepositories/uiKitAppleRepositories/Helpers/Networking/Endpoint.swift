//
//  Endpoint.swift
//  uiKitAppleRepositories
//
//  Created by Jun Zhang on 2022/1/20.
//

import Foundation

struct Endpoint {
    var path: String
    var httpMethod: String
    var queryItems: [URLQueryItem] = []
}
