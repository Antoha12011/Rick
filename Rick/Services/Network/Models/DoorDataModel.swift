//
//  DoorDataModel.swift
//  Rick
//
//  Created by Антон Павлов on 25.07.2023.
//

import Foundation

struct DoorData: Codable {
    let data: [Door]
}

struct Door: Codable {
    let name: String
    let room: String?
    let id: Int
    let favorites: Bool
    let snapshot: String?
}
