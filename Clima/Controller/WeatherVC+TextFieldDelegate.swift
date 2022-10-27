//
//  WeatherVC+TextFieldDelegate.swift
//  Clima
//
//  Created by advanc3d on 26.10.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit

extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            textField.placeholder = "Search"
            return true
        } else {
            textField.placeholder = "type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            weatherManager.fetchWeather(for: city)
        }
        searchTextField.text = ""
    }
}
