//
//  Weather.swift
//  Weather-App
//
//  Created by Михаил on 27.09.2023.
//

import Foundation

struct Weather: Codable {
    let main: Main
}

struct Main: Codable {
    let temp, tempMin, tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}
