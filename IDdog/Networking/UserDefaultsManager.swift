//
//  UserDefaults.swift
//  IDdog
//
//  Created by lugia on 16/09/18.
//  Copyright © 2018 MicFaifer. All rights reserved.
//

import Foundation

enum SettingKeys: String {
    case userKey
}

class UserDefaultsManager {
    static let shared = UserDefaultsManager()

    private init(){}

    var userToken: String? {
        get { return UserDefaults.standard.string(forKey: SettingKeys.userKey.rawValue) }
        set(value) { UserDefaults.standard.set(value, forKey: SettingKeys.userKey.rawValue) }
    }
}
