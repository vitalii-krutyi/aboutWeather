//
//  APIClientProtocol.swift
//  Weather
//
//  Created by Vitalii Krutyi on 21.05.2022.
//

import Foundation
import Alamofire

protocol APIClientProtocol {
    func currentWeather(lat: String, lon: String, appid: String, completion: @escaping APIResponseBlock<CurrentWeatherModel>)
}
