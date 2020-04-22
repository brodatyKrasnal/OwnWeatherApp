//
//  WeatherModel.swift
//  OwnWeatherApp
//
//  Created by Daniel Golęba Frygies on 17/04:108.
//  Copyright © 2020 Tymon Golęba Frygies. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: main
    let weather: [weather]
    let wind: wind
    let cod: Int
}

struct main: Codable {
    let temp: Double
    let feels_like: Double
    let pressure: Int
    let temp_min: Double
    let temp_max: Double
    let humidity: Int
}

struct weather: Codable{
    let id: Int
    let main: String
    let description: String
}

struct wind:Codable {
    let speed: Double
}
