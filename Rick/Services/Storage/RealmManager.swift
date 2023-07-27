//
//  RealmManager.swift
//  Rick
//
//  Created by Антон Павлов on 25.07.2023.
//

import Foundation
import RealmSwift

final class RealmManager {
    
    // MARK: - Properties
    
    static let shared = RealmManager()
    
    // MARK: - Public Methods
    
    func saveDataToRealm(data: [Camera]) {
        do {
            let realm = try! Realm()
            try realm.write {
                for item in data {
                    let realmDataObject = CamerasRealm()
                    realmDataObject.id = item.id
                    realmDataObject.name = item.name
                    realmDataObject.snapshot = item.snapshot
                    realmDataObject.favorites = item.favorites
                    realmDataObject.rec = item.rec
                    realmDataObject.room = item.room
                    realm.add(realmDataObject, update: .all)
                }
            }
        } catch let error as NSError {
            print("Error saving data to Realm: \(error)")
        }
    }
    
    func fetchDataFromNetwork() {
        let networkData: [Camera] = [
            Camera(id: 1, name: "Camera 1", snapshot: "https://serverspace.ru/wp-content/uploads/2019/06/backup-i-snapshot.png", favorites: true, rec: false, room: "FIRST"),
            Camera(id: 3, name: "Camera 2", snapshot: "https://serverspace.ru/wp-content/uploads/2019/06/backup-i-snapshot.png", favorites: true, rec: false, room: ""),
            Camera(id: 2, name: "Camera 45", snapshot: "https://serverspace.ru/wp-content/uploads/2019/06/backup-i-snapshot.png", favorites: false, rec: true, room: "FIRST"),
            Camera(id: 6, name: "Camera 89", snapshot: "https://serverspace.ru/wp-content/uploads/2019/06/backup-i-snapshot.png", favorites: true, rec: false, room: "FIRST")
        ]
        
        RealmManager.shared.saveDataToRealm(data: networkData)
    }
}
