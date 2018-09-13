//
//  DogFeedResult.swift
//  IDdog
//
//  Created by lugia on 13/09/18.
//  Copyright © 2018 MicFaifer. All rights reserved.
//

import Foundation

import Foundation

enum DogCategory: String, Codable {
    case husky, hound, pug, labrador
}

struct DogFeedResult: Codable {
    let category: DogCategory
    let list: [String]
}
