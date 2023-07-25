//
//  StorageLayer.swift
//  Rick
//
//  Created by Антон Павлов on 24.07.2023.
//

import RealmSwift
import Foundation

class RealmService {
    
    func saveData <T: Object> (array: [T], completion: @escaping () -> Void) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(array)
            try realm.commitWrite()
            DispatchQueue.main.async {
                completion()
            }
        } catch {
            debugPrint(error)
        }
    }
    
    func readData <T: Object> (object: T) -> [T] {
        do {
            let realm = try Realm()
            let objects = realm.objects(T.self)
            return Array(objects)
        } catch {
            debugPrint(error)
            return []
        }
    }
}
