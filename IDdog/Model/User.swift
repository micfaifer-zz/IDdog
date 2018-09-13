//
//  User.swift
//  IDdog
//
//  Created by lugia on 13/09/18.
//  Copyright © 2018 MicFaifer. All rights reserved.
//

import Foundation

struct User: Codable {
    let id, token, createdAt, updatedAt: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case token, createdAt, updatedAt
        case v = "__v"
    }
}
