//
//  RealmManager.swift
//  Rick
//
//  Created by Антон Павлов on 25.07.2023.
//

import Foundation

class RealmManager {
    
    // MARK: - Properties
    
    let realmService = RealmService()
    
    // MARK: - Public Methods
    
    func writeModel(networkModels: [Camera], completion: @escaping () -> Void) {
        var models: [CamerasRealm] = []
        networkModels.forEach { networkModel in
            let model = CamerasRealm()
            model.id = networkModel.id 
            model.name = networkModel.name 
            model.room = networkModel.room 
            models.append(model)
        }
        realmService.saveData(array: models) {
            completion()
        }
    }
    
    func readMeditationModels() -> [CamerasRealm] {
        let objects = realmService.readData(object: CamerasRealm())
        return objects
    }
}
