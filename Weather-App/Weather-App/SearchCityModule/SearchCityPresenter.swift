//
//  SearchCityPresenter.swift
//  Weather-App
//
//  Created by Михаил on 27.09.2023.
//

import Foundation

protocol ISearchCityPresenter: AnyObject {
    func viewDidLoad()
}

final class SearchCityPresenter {
    
    private let interactor: ISearchCityInteractor
    private weak var view: ISearchCityView?
    
    init(interactor: ISearchCityInteractor, view: ISearchCityView?) {
        self.interactor = interactor
        self.view = view
    }
}

extension SearchCityPresenter: ISearchCityPresenter {
    func viewDidLoad() {
        interactor.makeCitiesModels { [weak self] models in
            guard let self else { return }
            DispatchQueue.main.async {
                self.view?.showCities(with: models)
            }
        }
    }
}
