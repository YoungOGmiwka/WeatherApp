//
//  DetailCityAssembly.swift
//  Weather-App
//
//  Created by Михаил on 28.09.2023.
//

import Foundation
import UIKit

protocol IDetailCityAssembly: AnyObject {
    func assemble(for model: CityCellModel) -> UIViewController
}

final class DetailCityAssembly: IDetailCityAssembly {
    func assemble(for model: CityCellModel) -> UIViewController {
        let presenter = DetailCityPresenter(viewModel: model)
        let viewController = DetailCityViewController()
        
        presenter.view = viewController
        viewController.presenter = presenter
    
        return viewController
    }
}
