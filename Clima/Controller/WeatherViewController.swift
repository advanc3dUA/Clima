//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var currentLocationButton: UIButton!
    
    var weatherManager = WeatherManager()
    
    let locationManager = CLLocationManager()
    var currentLatitude: CLLocationDegrees?
    var currentLongitude: CLLocationDegrees?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentLocationButton.isHidden = true
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        searchTextField.delegate = self
        weatherManager.delegate = self
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
    }
    
    @IBAction func getToCurrentLocationPressed(_ sender: UIButton) {
        weatherManager.fetchWeather(latitude: currentLatitude, longitude: currentLongitude)
    }
    
}

