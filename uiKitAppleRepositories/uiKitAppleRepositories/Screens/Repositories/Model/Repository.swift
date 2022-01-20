//
//  Repository.swift
//  uiKitAppleRepositories
//
//  Created by Jun Zhang on 2022/1/20.
//

import Foundation

struct Repository: Equatable, Hashable, Decodable {
    var name: String
    var description: String?
    var createdAt: String
    var stargazersCount: Int
}

extension Repository {
    enum CodingKeys: String, CodingKey {
        case name
        case description
        case created_at
        case stargazers_count
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        createdAt = try container.decode(String.self, forKey: .created_at)
        stargazersCount = try container.decode(Int.self, forKey: .stargazers_count)
    }
}


