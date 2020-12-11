//
//  ServiceClient.swift
//  GorrilasLogicTest
//
//  Created by Felipe Correa on 10/12/20.
//  Copyright © 2020 Felipe & Co. Studios. All rights reserved.
//

import Foundation

enum WebClientError: Error {
    case errorWithCode(Int)
    case errorDecodingData
}

typealias RequestResultable<T> = (Result<T, WebClientError>) -> Void

protocol ServiceClientType {
    func loadRequest<T:Decodable>(urlRequest: URLRequest, completion: @escaping RequestResultable<T>)
}

final class ServiceClient: ServiceClientType {
    let urlSession: URLSession
    
    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func loadRequest<T:Decodable>(urlRequest: URLRequest, completion: @escaping RequestResultable<T>) {
        urlSession.dataTask(with: urlRequest) { (data, response, error) in
            if let data = data {
                do {
                    let responseObject = try JSONDecoder().decode(T.self, from: data)
                    let responseCode = (response as? HTTPURLResponse)?.statusCode ?? 404
                    switch responseCode {
                    case 200:
                        completion(.success(responseObject))
                    default:
                        completion(.failure(.errorWithCode(responseCode)))
                    }
                } catch {
                    completion(.failure(.errorDecodingData))
                }
            } else {
                completion(.failure(.errorDecodingData))
            }
        }.resume()
    }
}
