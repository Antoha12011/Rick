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
    @Persisted var name = ""
    @Persisted var room = ""
    @Persisted var snapshot = ""
//    @Persisted var favorites = ""
//    @Persisted var rec = ""
    
}
