//
//  ModelAPI.swift
//  Rick
//
//  Created by Антон Павлов on 27.07.2023.
//

import Foundation
import Alamofire

enum APIEndpoint {
    case getCameras
    case getRooms
}

protocol API {
    func url(for endpoint: APIEndpoint) -> URL?
}

struct ModelAPI: API {
    
    // MARK: - Constants
    
    private enum Constant {
        static let baseURL = "http://cars.cprogroup.ru/api/rubetek/"
    }
    
    // MARK: - Public Methods
    
    func url(for endpoint: APIEndpoint) -> URL? {
        URL(string: Constant.baseURL)?.appendingPathComponent(slug(for: endpoint))
    }
    
    // MARK: - Private Methods
    
    private func slug(for endpoint: APIEndpoint) -> String {
        switch endpoint {
        case .getCameras:
            return "cameras"
        case .getRooms:
            return "doors"
        }
    }
}
