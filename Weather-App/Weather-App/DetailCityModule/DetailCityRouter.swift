//
//  DetailCityRouter.swift
//  Weather-App
//
//  Created by Михаил on 28.09.2023.
//

import Foundation

protocol IDetailCityRouterProtocol: AnyObject {
    func closeCurrentViewController()
}

class DetailCityRouter: IDetailCityRouterProtocol {
    
    weak var viewController: DetailCityViewController?
    
    init(viewController: DetailCityViewController) {
        self.viewController = viewController
    }
    
    func closeCurrentViewController() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
