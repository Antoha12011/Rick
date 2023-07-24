//
//  DoorDataModel.swift
//  Rick
//
//  Created by Антон Павлов on 25.07.2023.
//

import Foundation

// Создаем структуру для представления всего JSON файла
struct DoorData: Codable {
    let data: [Door]?
}

// Создаем структуру для представления данных об объекте
struct Door: Codable {
    let name: String?
    let room: String?
    let id: Int?
    let favorites: Bool?
    let snapshot: String?
}
