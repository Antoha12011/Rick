//
//  APIClient.swift
//  Rick
//
//  Created by Антон Павлов on 27.07.2023.
//

import Foundation
import Alamofire


protocol APIClient {
    func get<T: Encodable>(_ data: T, url: URL, completion: @escaping (Result<Data?, Error>) -> Void)
}

// MARK: - Implementation

enum APIError: Error {
    case failureURL
    case uknownedError
}

final class DefaultAPIClient: APIClient {
    
    // MARK: - Types
    
    typealias Completion = (Result<Data?, Error>) -> Void
    
    // MARK: - Private Properties
    
    private let api: API
    private let timeOutModifier: Session.RequestModifier = { $0.timeoutInterval = 120 }
    
    init(api: API) {
        self.api = api
    }
    
    // MARK: - APIClient Methods
    
    func get<T: Encodable>(_ data: T, url: URL, completion: @escaping Completion) {
        AF.request(
            url,
            method: .get,
            requestModifier: timeOutModifier
        ).response { response in
            guard let data = response.data else {
                completion(.failure(APIError.uknownedError))
                return
            }
            completion(.success(data))
        }
    }
}
