//
//  SignUpService.swift
//  IDdog
//
//  Created by lugia on 13/09/18.
//  Copyright © 2018 MicFaifer. All rights reserved.
//

import Foundation

class SignUpService {
    typealias signUpResult = (Result< SignUpResult, APIError>) -> ()

    func signUp (emailAddress: String, completion: @escaping signUpResult) {
        if var urlComponents = URLComponents(string: DogAPI.baseURL) {
            urlComponents.path = DogAPI.signUP
            urlComponents.query = "email=\(emailAddress)"
            guard let url = urlComponents.url else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let parameters = ["email": emailAddress]

            if let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: []) {
                request.httpBody = jsonData
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")

                URLSession.shared.dataTask(with: request) { (data, response, error) in
                    if let error = error, error._code == NSURLErrorNotConnectedToInternet  {
                        completion(Result.failure(APIError.noConnection))
                    }

                    if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                        do {
                            //decode
                            let jsonDecoder = JSONDecoder()
                            let result = try jsonDecoder.decode(SignUpResult.self, from: data)
                            completion(Result.success(result))
                        } catch {
                            // decoding error
                            completion(Result.failure(APIError.jsonParsingFailure))
                        }
                    } else {
                        return completion(Result.failure(APIError.requestFailed))
                    }

                    }.resume()
            } else {
               return completion(Result.failure(APIError.requestFailed))
            }
        }
    }
}
