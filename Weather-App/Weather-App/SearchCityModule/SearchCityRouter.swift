//
//  SearchCityRouter.swift
//  Weather-App
//
//  Created by Михаил on 27.09.2023.
//

import Foundation
import UIKit

protocol ISearchCityRouterProtocol: AnyObject {
    
    var entry: SearchCityResultsViewController? { get }
    static func startExecution() -> ISearchCityRouterProtocol
    func gotoDetailView()
    
}
