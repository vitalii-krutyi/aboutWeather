//
//  APIClientProtocol.swift
//  Weather
//
//  Created by Vitalii Krutyi on 21.05.2022.
//

import Foundation
import Alamofire

protocol APIClientProtocol {
    func currentWeather(city: String, appid: String, unit: TemperatureUnit, completion: @escaping APIResponseBlock<CurrentWeatherModel>)
}
