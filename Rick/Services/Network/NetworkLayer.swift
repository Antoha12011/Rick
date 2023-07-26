//
//  Services .swift
//  Rick
//
//  Created by Антон Павлов on 24.07.2023.
//

import Foundation
import UIKit

final class NetworkService {
    func getData() {
        var request = URLRequest(url: URL(string: "http://cars.cprogroup.ru/api/rubetek/cameras/")!,timeoutInterval: Double.infinity)
        request.addValue("PHPSESSID=9e62b478fb782c640aaf3e5705d70f17", forHTTPHeaderField: "Cookie")
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            print(String(data: data, encoding: .utf8)!)
        }
        task.resume()
    }
}
