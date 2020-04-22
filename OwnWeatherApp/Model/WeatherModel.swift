//
//  WeatherModel.swift
//  OwnWeatherApp
//
//  Created by Daniel Golęba Frygies on 19/04:110.
//  Copyright © 2020 Tymon Golęba Frygies. All rights reserved.
//

import Foundation

struct WeatherModel {
    
    let cityName: String
    let pressure: Int
    let tempMin: Double
    let tempMax: Double
    let humidity: Int
    let temperature: Double
    let feelingLike: Double
    let conditionID: Int
    
    var tempString: String {
        return String(format: "%.0f", temperature)
    }
    var tempMinString: String {
        return String(format: "%.0f",tempMin)
    }
    
    var tempMaxString: String {
        return String(format: "%.0f",tempMax)
    }
    var tempFeelsLikeString: String {
        return String(format: "%.0f",feelingLike)
    }
    
    var conditionName: String {
        switch conditionID {
        case 200...232:
            return "thunderstorm"
        case 300...321:
            return "rain-1"
        case 500...531:
            return "rain"
        case 600...622:
            return "snow"
        case 701...730:
            return "mist"
        case 731:
            return "dust"
        case 732...781:
            return "mist"
        case 800:
            return "clear_sky"
        case 801...804:
            return "clouds"
        default:
            return "clouds"
        }
    }

}
