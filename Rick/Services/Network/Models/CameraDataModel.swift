//
//  CamerasModel.swift
//  Rick
//
//  Created by Антон Павлов on 24.07.2023.
//

import Foundation

struct CameraDataModel: Codable {
    let success: Bool
    let data: DataModel
}

struct DataModel: Codable {
    let room: [String]
    let cameras: [Camera]
}

struct Camera: Codable {
    let id: Int
    let name: String
    let snapshot: String
    let favorites: Bool
    let rec: Bool
    let room: String?
}

