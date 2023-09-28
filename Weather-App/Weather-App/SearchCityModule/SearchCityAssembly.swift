//
//  SearchCityAssembly.swift
//  Weather-App
//
//  Created by Михаил on 27.09.2023.
//

import Foundation
import UIKit

protocol ISearchCityAssembly: AnyObject {
    func assemle() -> UIViewController
}

class SearchCityAssembly: ISearchCityAssembly {
    func assemle() -> UIViewController {
        SearchCityViewController()
    }
}
