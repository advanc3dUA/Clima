//
//  WeatherManager.swift
//  Clima
//
//  Created by advanc3d on 26.10.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=da87fa9177d74dc01a4fbd98b78c121d&units=metric"
    func fetchWeather(for city: String) {
        let safeCity = removeSpaceSuffixIfNeeded(for: city)
        let urlString = "\(weatherURL)&q=\(safeCity)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let safeData = data {
                self.parseJSON(weatherData: safeData)
            }
        }
        task.resume()
    }
    
    private func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let city = decodedData.name
            let temp = decodedData.main.temp
            let id = decodedData.weather[0].id
            
            let weather = WeatherModel(cityName: city, temperature: temp, conditionID: id)
            
        } catch {
            print(error.localizedDescription)
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
