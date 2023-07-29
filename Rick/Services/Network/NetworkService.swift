//
//  Services .swift
//  Rick
//
//  Created by Антон Павлов on 24.07.2023.
//

import Foundation

final class NetworkService {
    
    private let apiClient: APIClient = DefaultAPIClient(api: ModelAPI())
    private let modelApi = ModelAPI()
    
    func getData(completion: @escaping (DataModel) -> Void) {
        guard let url = modelApi.url(for: .getCameras) else { return }
        apiClient.get(String(), url: url) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                guard let data = data else { return }
                do {
                    let model = try JSONDecoder().decode(CameraDataModel.self, from: data)
                    completion(model.data)
                } catch {
                    debugPrint("Ошибка декодирования: \(error)")
                }
            }
        }
    }

}
