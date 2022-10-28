//
//  WeatherVC+CLLoсationDelegate.swift
//  Clima
//
//  Created by Yuriy Gudimov on 28.10.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            currentLatitude = location.coordinate.latitude
            currentLongitude = location.coordinate.longitude
            currentLocationButton.isHidden = false
            weatherManager.fetchWeather(latitude: currentLatitude, longitude: currentLongitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
