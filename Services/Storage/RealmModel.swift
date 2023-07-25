//
//  RealmModel.swift
//  Rick
//
//  Created by Антон Павлов on 24.07.2023.
//

import Foundation
import RealmSwift

class CamerasRealm: Object {
    @Persisted(primaryKey: true) var id = 0
    @Persisted var name: String?
    @Persisted var room: String?
    @Persisted var snapshot: String = "https://serverspace.ru/wp-content/uploads/2019/06/backup-i-snapshot.png"
    @Persisted var favorites: Bool?
    @Persisted var rec: Bool?
    
}
