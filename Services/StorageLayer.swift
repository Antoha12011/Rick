////
////  StorageLayer.swift
////  Rick
////
////  Created by Антон Павлов on 24.07.2023.
////
//
//import RealmSwift
//
//class StorageManager {
//    static let shared = StorageManager()
//
//    let realm = try! Realm()
//
//    private init() {}
//
//    func save(favoriteChannel: CamerasRealm) {
//        write {
//            realm.add(favoriteChannel)
//        }
//    }
//
//    func delete(favoriteChannel: CamerasRealm) {
//        write {
//            let object = realm.objects(CamerasRealm.self).filter("name = %@", favoriteChannel.name)
//            realm.delete(object)
//        }
//    }
//
//    private func write(_ completion: () -> Void) {
//        do {
//            try realm.write { completion() }
//        } catch let error {
//            print(error)
//        }
//    }
//
//}
//
//
