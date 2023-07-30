import Foundation
import RealmSwift

final class RealmManager {
    
    static let shared = RealmManager()
    
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
    
    func fetchCameras() -> Results<CamerasRealm>? {
        let realm = try! Realm()
        let cameras = realm.objects(CamerasRealm.self)
        return cameras
    }
}

