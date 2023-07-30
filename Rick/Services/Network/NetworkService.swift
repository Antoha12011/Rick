//
//  Services .swift
//  Rick
//
//  Created by Антон Павлов on 24.07.2023.
//

import Foundation
import RealmSwift

final class NetworkService {
    
    private let apiClient: APIClient = DefaultAPIClient(api: ModelAPI())
    private let modelApi = ModelAPI()
    
    func getCameras(completion: @escaping (DataModel) -> Void) {
        guard let url = modelApi.url(for: .getCameras) else { return }
        apiClient.get(String(), url: url) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                guard let data = data else { return }
                do {
                    let model = try JSONDecoder().decode(CameraDataModel.self, from: data)
                    RealmManager.shared.saveDataToRealm(data: model.data.cameras)
                    completion(model.data)
                } catch {
                    debugPrint("Ошибка декодирования: \(error)")
                }
            }
        }
    }
    
    func getDoors(completion: @escaping (DoorData?) -> Void) {
        guard let url = modelApi.url(for: .getRooms) else { return }
        apiClient.get(String(), url: url) { result in
            switch result {
            case .failure(let error):
                print(error)
                completion(nil)
            case .success(let data):
                guard let data = data else {
                    completion(nil)
                    return
                }
                do {
                    let model = try JSONDecoder().decode(DoorData.self, from: data)
                    RealmManager.shared.saveRoomsToRealm(data: model.data)
                    completion(model)
                } catch {
                    debugPrint("Ошибка декодирования: \(error)")
                    completion(nil)
                }
            }
        }
    }
}
