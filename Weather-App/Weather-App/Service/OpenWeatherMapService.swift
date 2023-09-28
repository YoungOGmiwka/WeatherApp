//
//  OpenWeatherMapService.swift
//  Weather-App
//
//  Created by Михаил on 27.09.2023.
//

import Foundation

private extension String {
    static let appid = "ac5cbd120985f291b0d65be1ccd22a77"
}

private extension URL {
    static func loadCoordinatesUrl(for cityName: String) -> URL? {
        URL(string: "http://api.openweathermap.org/geo/1.0/direct?q=\(cityName)&limit=100&appid=\(String.appid)")
    }
    
    static func loadCurrentWeatherUrl(lon: Double, lat: Double) -> URL? {
        URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(String.appid)&units=metric")
    }
}

enum OpenWeatherMapService {
    static func loadCoordinates(using cityName: String,
                                completionHandler: @escaping (Result<[CityCoordinates], Error>) -> Void) {
        guard let url = URL.loadCoordinatesUrl(for: cityName) else {
            completionHandler(.failure(NSError()))
            return
        }
        let request = URLRequest(url: url)
        load(request, decode: [CityCoordinates].self, completionHandler: completionHandler)
    }
    static func loadCurrentWeather(lon: Double,
                                   lat: Double,
                                   completionHandler: @escaping (Result<Weather, Error>) -> Void) {
        guard let url = URL.loadCurrentWeatherUrl(lon: lon, lat: lat) else {
            completionHandler(.failure(NSError()))
            return
        }
        let request = URLRequest(url: url)
        load(request, decode: Weather.self, completionHandler: completionHandler)
    }
    
    private static func load<T: Codable>(_ request: URLRequest,
                                         decode to: T.Type,
                                         completionHandler: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error {
                completionHandler(.failure(error))
                return
            }
            if let data {
                let decoder = JSONDecoder()
                let model = try? decoder.decode(to, from: data)
                if let model {
                    completionHandler(.success(model))
                } else {
                    completionHandler(.failure(NSError()))
                }
            } else {
                completionHandler(.failure(NSError()))
                return
            }
        }.resume()
    }
}
