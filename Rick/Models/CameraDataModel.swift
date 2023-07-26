//
//  CamerasModel.swift
//  Rick
//
//  Created by Антон Павлов on 24.07.2023.
//

import Foundation

// Структура для представления данных
struct CameraDataModel: Codable {
    let success: Bool
    let data: CameraData
}

struct CameraData: Codable {
    let room: [String]?
    let cameras: [Camera]
}

// Структура для представления камеры
struct Camera: Codable {
    let name: String
    let snapshot: String
    let room: String?
    let id: Int
    let favorites, rec: Bool
    
    init(id: Int, name: String, snapshot: String, favorites: Bool, rec: Bool, room: String ) {
        self.id = id
        self.name = name
        self.favorites = favorites
        self.rec = rec
        self.snapshot = snapshot
        self.room = room
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case snapshot = "snapshot"
        case room = "room"
        case id = "id"
        case favorites = "favorites"
        case rec = "rec"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.snapshot = try container.decode(String.self, forKey: .snapshot)
        self.room = try container.decode(String.self, forKey: .room)
        self.id = try container.decode(Int.self, forKey: .id)
        self.favorites = try container.decode(Bool.self, forKey: .favorites)
        self.rec = try container.decode(Bool.self, forKey: .rec)
    }
}
