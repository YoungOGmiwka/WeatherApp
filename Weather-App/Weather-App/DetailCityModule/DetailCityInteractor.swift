//
//  DetailCityInteractor.swift
//  Weather-App
//
//  Created by Михаил on 28.09.2023.
//

import Foundation

protocol IDetailCityInteractorProtocol: AnyObject {
    
}

class DetailCityInteractor: IDetailCityInteractorProtocol {
    
    weak var presenter: IDetailCityPresenter?
    
    required init(presenter: IDetailCityPresenter) {
        self.presenter = presenter
    }
}
