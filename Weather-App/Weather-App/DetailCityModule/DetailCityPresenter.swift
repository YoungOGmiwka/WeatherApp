//
//  SearchCityResultsPresenter.swift
//  Weather-App
//
//  Created by Михаил on 28.09.2023.
//

import Foundation
import UIKit

protocol IDetailCityPresenter: AnyObject {
    func viewDidLoad()
    func didTapShowThreeDays()
    func didTapShowWeek()
}

final class DetailCityPresenter {

    // Dependencies
    weak var view: IDetailCityView?

    // Properties
    private var viewModel: CityCellModel

    // MARK: - Init

    init(viewModel: CityCellModel) {
        self.viewModel = viewModel
    }
}

// MARK: - IDetailCityPresenter

extension DetailCityPresenter: IDetailCityPresenter {
    
    func viewDidLoad() {
        view?.configure(with: viewModel)
    }

    func didTapShowThreeDays() {
        //
    }

    func didTapShowWeek() {
        //
    }
}
