//
//  CamerasModel.swift
//  Rick
//
//  Created by Антон Павлов on 24.07.2023.
//

import Foundation

struct CameraDataModel: Codable {
    let success: Bool
    let data: CameraData
}

struct CameraData: Codable {
    let room: [String]?
    let cameras: [Camera]
}

struct Camera: Codable {
    let id: Int
    let name: String
    let snapshot: String
    let favorites, rec: Bool
    let room: String?
}
