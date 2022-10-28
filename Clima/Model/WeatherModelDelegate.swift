//
//  WeatherModelDelegate.swift
//  Clima
//
//  Created by Yuriy Gudimov on 28.10.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherModelDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(with error: Error)
}
