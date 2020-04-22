//
//  WeatherManager.swift
//  OwnWeatherApp
//
//  Created by Daniel Golęba Frygies on 18/04:109.
//  Copyright © 2020 Tymon Golęba Frygies. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError (error: Error)
}

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=4e8a421727a0b28408f0157ee4a36b96"
    
    func fetchWeather (cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: Double, longitude: Double) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        print(urlString)
        performRequest(with: urlString)
    }
    
    var delegate: WeatherManagerDelegate?
    
    func performRequest(with urlString: String) {
        //1. create URL
        
        if let url = URL(string: urlString) {
            
            //2. cteate url Session
            let session = URLSession(configuration: .default)
            
            //3. assign the task
            
            let task =  session.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weatherObject = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather: weatherObject)
                    }
                }
            }
            task.resume()
        }
    }
    
    
    func parseJSON (_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        
        do{
            let decodedData =  try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let cityName = decodedData.name
            let pressure = decodedData.main.pressure
            let tempMin = decodedData.main.temp_min
            let tempMax = decodedData.main.temp_max
            let humidity = decodedData.main.humidity
            let temp = decodedData.main.temp
            let feelsLike = decodedData.main.feels_like
            
            let weatherObject = WeatherModel(cityName: cityName, pressure: pressure, tempMin: tempMin, tempMax: tempMax, humidity: humidity, temperature: temp, feelingLike: feelsLike, conditionID: id)
            return weatherObject
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
}
