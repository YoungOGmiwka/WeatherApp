//
//  CityCoordinates.swift
//  Weather-App
//
//  Created by Михаил on 27.09.2023.
//

import Foundation

struct CityCoordinates: Codable {
    let name: String
    let lat, lon: Double
    let country: String
}
