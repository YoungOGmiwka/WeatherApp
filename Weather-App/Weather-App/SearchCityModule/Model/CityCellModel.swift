//
//  CityCellModel.swift
//  Weather-App
//
//  Created by Михаил on 27.09.2023.
//

import Foundation
import UIKit

struct CityCellModel: UIContentConfiguration, Hashable {
    let uuid = UUID()
    let city: String
    let temperature: String
    
    func makeContentView() -> UIView & UIContentView {
        CityCellContentView(configuration: self)
    }
    
    func updated(for state: UIConfigurationState) -> CityCellModel { self }
}
