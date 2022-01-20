//
//  Networker.swift
//  uiKitAppleRepositories
//
//  Created by Jun Zhang on 2022/1/20.
//

import Foundation
import Combine

enum NetworkState {
    case idle
    case loading
    case failed
    case success
}

var timeoutIntervalForRequest: TimeInterval = 40

protocol NetworkerProtocol: AnyObject {
    func fetch<T>(type: T.Type,
                  url: URL,
                  httpMethod: String) -> AnyPublisher<T, Error> where T: Decodable
}

final class Networker: NetworkerProtocol {
    func fetch<T>(type: T.Type,
                  url: URL,
                  httpMethod: String) -> AnyPublisher<T, Error> where T: Decodable {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod

        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")

        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
