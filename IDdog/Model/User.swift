//
//  User.swift
//  IDdog
//
//  Created by lugia on 13/09/18.
//  Copyright © 2018 MicFaifer. All rights reserved.
//

import Foundation

struct User: Codable {
    let token: String
    let id, createdAt, updatedAt: String?
    let v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case token, createdAt, updatedAt
        case v = "__v"
    }

    init(token: String, id: String? = nil, createdAt: String? = nil, updatedAt: String? = nil, v: Int? = nil) {
        self.token = token
        self.id = id
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.v = v
    }
}
