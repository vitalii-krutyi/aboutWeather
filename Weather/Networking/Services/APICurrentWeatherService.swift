//
//  APICurrentWeatherService.swift
//  Weather
//
//  Created by Vitalii Krutyi on 21.05.2022.
//

import Foundation
import Alamofire

enum TemperatureUnit: String {
    case fahrenheit = "standard"
    case celsius = "metric"
    case kelvin = "imperial"
}

enum APICurrentWeatherService: APIBaseServiceProtocol {
    case currentWeather(city: String, appid: String, unit: TemperatureUnit)
    
    var method: HTTPMethod { .get }
    
    var path: String {
        switch self {
        case .currentWeather:
            return "weather?"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .currentWeather(let city, let appid, let unit):
            return [
                "appid": appid,
                "units": unit.rawValue,
                "q": city
            ]
        }
    }
    
    var encoding: EncodingType { .url }
    
    var headers: HTTPHeaders? { nil }
}
