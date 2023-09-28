//
//  ApplicationCoordinator.swift
//  Weather-App
//
//  Created by Михаил on 28.09.2023.
//

import Foundation
import UIKit

protocol IApplicationCoordinatorProtocol {
}

final class ApplicationCoordinator: IApplicationCoordinatorProtocol {
    
    private let transitionHandler: UINavigationController
    
    private let searchCityAssembly: ISearchCityAssembly
    
    init(transitionHandler: UINavigationController, searchCityAssembly: ISearchCityAssembly) {
        self.transitionHandler = transitionHandler
        self.searchCityAssembly = searchCityAssembly
    }
    
    func start() {
        let viewController = searchCityAssembly.assemle()
        transitionHandler.setViewControllers([viewController], animated: true)
    }
}
