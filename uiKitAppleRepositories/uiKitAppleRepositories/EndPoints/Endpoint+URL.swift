//
//  Endpoint+URL.swift
//  uiKitAppleRepositories
//
//  Created by Jun Zhang on 2022/1/20.
//

import Foundation

//https://docs.github.com/en/rest/reference/repos#get-a-repository
// https://api.github.com/orgs/apple/repos?type=owner&

extension Endpoint {

    func findURL() -> URL {
        var components = URLComponents()

        components.scheme = "https"
        components.host = "api.github.com"
        components.path = "/" + path

        components.queryItems = queryItems

        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }

        return url
    }
}
