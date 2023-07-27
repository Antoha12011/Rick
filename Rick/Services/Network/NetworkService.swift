//
//  Services .swift
//  Rick
//
//  Created by Антон Павлов on 24.07.2023.
//

import Foundation

final class NetworkService {
    
    static let shared = NetworkService()
    
    let urlString = "http://cars.cprogroup.ru/api/rubetek/cameras/"
    
    func getCameras() {
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else { return }
            
            if (try? JSONDecoder().decode(Camera.self, from: data)) != nil {
                print("Success")
            } else {
                print("Error")
            }
        }
        task.resume()
    }
}
