//
//  Endpoint+Repos.swift
//  uiKitAppleRepositories
//
//  Created by Jun Zhang on 2022/1/20.
//

import Foundation

extension Endpoint {

    static func repos(organisation: String, page: Int, perPage: Int) -> Self {
        return Endpoint(path: "orgs/\(organisation)/repos",
                        httpMethod: "GET",
                        queryItems: [
                            URLQueryItem(name: "type", value: "owner"),
                            URLQueryItem(name: "page", value: "\(page)"),
                            URLQueryItem(name: "per_page", value: "\(perPage)")
                        ]
        )
    }
}
