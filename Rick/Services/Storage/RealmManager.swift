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
    
    private init() {}
    
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
}
