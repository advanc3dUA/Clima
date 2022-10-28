//
//  WeatherManager.swift
//  Clima
//
//  Created by advanc3d on 26.10.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=da87fa9177d74dc01a4fbd98b78c121d&units=metric"
    var delegate: WeatherModelDelegate?
    
    func fetchWeather(for city: String? = nil, latitude: CLLocationDegrees? = nil, longitude: CLLocationDegrees? = nil) {
        if let city = city {
            let safeCity = removeSpaceSuffixIfNeeded(for: city)
            let urlString = "\(weatherURL)&q=\(safeCity)"
            performRequest(with: urlString)
        } else if let lat = latitude, let lon = longitude {
            let urlString = "\(weatherURL)&lat=\(lat)&lon=\(lon)"
            performRequest(with: urlString)
        }
    }
    
    func performRequest(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                self.delegate?.didFailWithError(with: error)
                return
            }
            
            if let safeData = data {
                if let weather = self.parseJSON(safeData) {
                    delegate?.didUpdateWeather(self, weather: weather)
                }
            }
        }
        task.resume()
    }
    
    private func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let city = decodedData.name
            let temp = decodedData.main.temp
            let id = decodedData.weather[0].id
            let weather = WeatherModel(cityName: city, temperature: temp, conditionID: id)
            return weather
        } catch {
            self.delegate?.didFailWithError(with: error)
            return nil
        }
    }
    
    private func removeSpaceSuffixIfNeeded(for city: String) -> String {
        var result = city
        if result.hasSuffix(" ") {
            result.removeLast()
            return result
        }
        return result
    }
}
