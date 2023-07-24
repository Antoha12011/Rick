//
//  CamerasModel.swift
//  Rick
//
//  Created by Антон Павлов on 24.07.2023.
//

import Foundation

// Структура для представления камеры
struct Camera: Codable {
    let name: String?
    let snapshot: String?
    let room: String?
    let id: Int?
    let favorites: Bool?
    let rec: Bool?
}

// Структура для представления данных
struct CameraDataModel: Codable {
    let success: Bool?
    let data: CameraData?
}

struct CameraData: Codable {
    let room: [String]?
    let cameras: [Camera]?
}
