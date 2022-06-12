//
//  APIClient+CurrentWeather.swift
//  Weather
//
//  Created by Vitalii Krutyi on 21.05.2022.
//

import Foundation

extension APIClient {
    func currentWeather(lat: String, lon: String, appid: String, completion: @escaping APIResponseBlock<CurrentWeatherModel>) {
        let service = APICurrentWeatherService.currentWeather(lat: lat, lon: lon, appid: appid)
        fetch(service: service, completion: completion)
    }
}
