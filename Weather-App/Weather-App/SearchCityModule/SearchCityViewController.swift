//
//  SearchCityViewController.swift
//  Weather-App
//
//  Created by Михаил on 27.09.2023.
//

import Foundation
import UIKit
import SnapKit

protocol ISearchCityView: AnyObject {
    func showCities(with models: [CityCellModel])
}

final class SearchCityViewController: UIViewController {
    
    private lazy var searchController: UISearchController = {
        let resultController = SearchCityResultsViewController()
        resultController.itemsDataSource = self
        let searchController = UISearchController(searchResultsController: resultController)
        searchController.searchBar.delegate = self
        searchController.delegate = self
        return searchController
    }()
    
    private lazy var placeholderView = SearchCityPlaceholderView(frame: .zero)
    
    var items: [CityCellModel] = []
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        view.backgroundColor = .white
        title = "Ваши города"
        navigationItem.searchController = searchController
        
        view.addSubview(placeholderView)
        placeholderView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}

extension SearchCityViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        OpenWeatherMapService.loadCoordinates(using: searchBar.text ?? "") {[weak self] result in
            switch result {
            case .success(let success):
                self?.items = []
                let group = DispatchGroup()
                for item in success {
                    group.enter()
                    OpenWeatherMapService.loadCurrentWeather(lon: item.lon, lat: item.lat) { weather in
                        switch weather {
                        case .success(let success):
                            let temp = Int(success.main.temp)
                            let city = "\(item.name) \(item.country)"
                            self?.items.append(CityCellModel(city: city, temperature: "\(temp)"))
                        case .failure(let failure):
                            print("Fail")
                        }
                        group.leave()
                    }
                }
                group.notify(queue: DispatchQueue.main) {
                    (self?.searchController.searchResultsController as? SearchCityResultsViewController)?.configure()
                }
            case .failure:
                print("Fail")
            }
        }
    }
}

extension SearchCityViewController: UISearchControllerDelegate {
    
    func willPresentSearchController(_ searchController: UISearchController) {
        let animations = {
            self.placeholderView.isHidden = true
            self.placeholderView.layer.opacity = 0
        }
        UIView.animate(withDuration: 0.5,
                       delay: 0.1,
                       options: .curveEaseInOut,
                       animations: animations,
                       completion: nil)
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        let animations = {
            self.placeholderView.isHidden = false
            self.placeholderView.layer.opacity = 1
        }
        UIView.animate(withDuration: 0.5,
                       delay: 0.1,
                       animations: animations,
                       completion: nil)
    }
}

extension SearchCityViewController: SearchCityResultsViewControllerDataSource {
    
}

extension SearchCityViewController: ISearchCityView {
    func showCities(with models: [CityCellModel]) {
        let resultsViewController = SearchCityResultsViewController()
        items = models
        resultsViewController.itemsDataSource = self
        addChild(resultsViewController)
        resultsViewController.willMove(toParent: self)
    }
}
