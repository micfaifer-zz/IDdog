//
//  APIError.swift
//  IDdog
//
//  Created by lugia on 13/09/18.
//  Copyright © 2018 MicFaifer. All rights reserved.
//

import Foundation

enum APIError: Error {
    case requestFailed
    case jsonParsingFailure
    case noConnection
    
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Algo deu errado na requisição"
        case .jsonParsingFailure: return "Falha nos dados"
        case .noConnection: return "Parece que você está sem conexão com a Internet ☹️"
        }
    }
}
