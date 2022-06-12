//
//  APICurrentWeatherService.swift
//  Weather
//
//  Created by Vitalii Krutyi on 21.05.2022.
//

import Foundation
import Alamofire

enum APICurrentWeatherService: APIBaseServiceProtocol {
    case currentWeather(lat: String, lon: String, appid: String)
    
    var method: HTTPMethod { .get }
    
    var path: String {
        switch self {
        case .currentWeather:
            return "weather?"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .currentWeather(let lat, let lon, let appid):
            return [
                "lat": lat,
                "lon": lon,
                "appid": appid
            ]
        }
    }
    
    var encoding: EncodingType { .url }
    
    var headers: HTTPHeaders? { nil }
}
