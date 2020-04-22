//
//  ViewController.swift
//  OwnWeatherApp
//
//  Created by Daniel Golęba Frygies on 17/04:108.
//  Copyright © 2020 Tymon Golęba Frygies. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController{
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityPickedLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var feelLikeTempLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    var lat: Double = 0.0
    var lon: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hour()
        
        cityTextField.delegate = self
        weatherManager.delegate = self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
       
    func hour (){
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        
        switch hour {
            case 7...19:
            backgroundImage.image = UIImage(named: "DayBackground")
            view.backgroundColor = UIColor.init(red: 19, green: 24, blue: 98, alpha: 1)
        default:
            backgroundImage.image =  UIImage(named: "NightBackground")
            view.backgroundColor = UIColor.init(red: 19, green: 24, blue: 98, alpha: 1)
        }
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        cityTextField.endEditing(true)
    }

    
}
//MARK: - CLLOcation Manager Delegate
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            lat = location.coordinate.latitude
            lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    @IBAction func LocateButtonPressed(_ sender: UIButton) {
        weatherManager.fetchWeather(latitude: lat, longitude: lon)
    }
}

//MARK: - Weather Manager Delegate
extension ViewController: WeatherManagerDelegate {
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel){
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.tempString
            self.cityPickedLabel.text = weather.cityName
            self.minTempLabel.text = weather.tempMinString
            self.maxTempLabel.text = weather.tempMaxString
            self.pressureLabel.text = "\(weather.pressure)"
            self.humidityLabel.text = "\(weather.humidity)% humid"
            self.feelLikeTempLabel.text = weather.tempFeelsLikeString
            self.weatherIcon.image = UIImage(named: weather.conditionName)
            print(weather.conditionName)
        }
         
    }
    
}

//MARK: - Text Field Delegate
extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Provide your city"
            return true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = cityTextField.text {
            cityPickedLabel.text = city
            weatherManager.fetchWeather(cityName: city)
             cityTextField.text = ""
        }
        textField.endEditing(true)
    }
}

