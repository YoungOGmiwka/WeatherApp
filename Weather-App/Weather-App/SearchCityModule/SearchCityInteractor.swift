//
//  SearchCityInteractor.swift
//  Weather-App
//
//  Created by Михаил on 27.09.2023.
//

import Foundation
import CoreData
import UIKit

protocol ISearchCityInteractor: AnyObject {
    func makeCitiesModels(completionHandler: @escaping ([CityCellModel]) -> Void)
    func loadCities(for query: String, completionHandler: @escaping ([CityCellModel]) -> Void)
}

final class SearchCityInteractor {
    
    private var cities: [City]
    private var context: NSManagedObjectContext
    
    init() {
        self.context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        self.cities = (try? context.fetch(NSFetchRequest(entityName: "City"))) ?? []
    }
    
    // Загружаем города из кэша и для них из сети загружаем текущую температуру
    func makeCitiesModels(completionHandler: @escaping ([CityCellModel]) -> Void) {
        if cities.isEmpty {
            completionHandler([])
            return
        }
        let group = DispatchGroup()
        var models = [CityCellModel]()
        for city in cities {
            group.enter()
            OpenWeatherMapService.loadCurrentWeather(lon: city.lon,
                                                     lat: city.lat) { result in
                if case let .success(res) = result {
                    let model = CityCellModel(city: city.name ?? "", temperature: "\(res.main.temp)")
                    models.append(model)
                }
                group.leave()
            }
        }
        group.notify(queue: .main) {
            completionHandler(models)
        }
    }
    
    // По запросу загружает города и текущую температуру в них
    func loadCities(for query: String, completionHandler: @escaping ([CityCellModel]) -> Void) {
        OpenWeatherMapService.loadCoordinates(using: query) { [weak self] result in
            if case let .success(res) = result {
                let group = DispatchGroup()
                var models = [CityCellModel]()
                for city in res {
                    group.enter()
                    OpenWeatherMapService.loadCurrentWeather(lon: city.lon,
                                                             lat: city.lat) { result in
                        if case let .success(res) = result {
                            let model = CityCellModel(city: city.name, temperature: "\(res.main.temp)")
                            models.append(model)
                        }
                        group.leave()
                    }
                }
                group.notify(queue: .main) {
                    completionHandler(models)
                }
            }
        }
    }
}
