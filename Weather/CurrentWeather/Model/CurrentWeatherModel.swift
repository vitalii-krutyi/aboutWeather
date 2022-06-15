//
//  CurrentWeatherModel.swift
//  Weather
//
//  Created by Vitalii Krutyi on 21.05.2022.
//

import Foundation

class CurrentWeatherModel: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
}

class Coord: Codable {
    let lon: Double
    let lat: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

class Main: Codable {
    private enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
    }
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let humidity: Int
}

class Wind: Codable {
    let speed: Double
    let deg: Int
}

class Clouds: Codable {
    let all: Int
}

class Sys: Codable {
    //    let type: Int
    //    let id: Int
    //    let message: Double
    let country: String
    let sunrise: Int
    let sunset: Int
}
