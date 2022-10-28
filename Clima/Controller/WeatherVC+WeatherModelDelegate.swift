//
//  WeatherVC+WeatherModelDelegate.swift
//  Clima
//
//  Created by Yuriy Gudimov on 28.10.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit

extension WeatherViewController: WeatherModelDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        let queue = DispatchQueue.main
        queue.async {
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.temperatureLabel.text = weather.temperatureString
            self.cityLabel.text = weather.cityName
        }
    }
    
    func didFailWithError(with error: Error) {
        print(error.localizedDescription)
    }
}
