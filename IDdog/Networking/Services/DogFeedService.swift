//
//  DogFeedService.swift
//  IDdog
//
//  Created by lugia on 13/09/18.
//  Copyright © 2018 MicFaifer. All rights reserved.
//

import Foundation

class DogFeedService {
    typealias dogFeedResult = (Result< DogFeedResult, APIError>) -> ()

    func fetchDogs (dogCategory: DogCategory = DogCategory.husky, userKey: String , completion: @escaping dogFeedResult) {
        if var urlComponents = URLComponents(string: DogAPI.baseURL) {
            urlComponents.path = DogAPI.feed
            urlComponents.query = "category=\(dogCategory)"
            guard let url = urlComponents.url else { return }
            var request = URLRequest(url: url)
            request.addValue(userKey, forHTTPHeaderField: "Authorization")

            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error, error._code == NSURLErrorNotConnectedToInternet  {
                    completion(Result.failure(APIError.noConnection))
                }

                if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    do {
                        //decode
                        let jsonDecoder = JSONDecoder()
                        let result = try jsonDecoder.decode(DogFeedResult.self, from: data)
                        completion(Result.success(result))
                    } catch {
                        // decoding error
                        completion(Result.failure(APIError.jsonParsingFailure))
                    }
                } else {
                    return completion(Result.failure(APIError.requestFailed))
                }

                }.resume()
        }
    }
}
