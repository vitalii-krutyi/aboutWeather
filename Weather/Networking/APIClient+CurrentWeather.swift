//
//  APIClient+CurrentWeather.swift
//  Weather
//
//  Created by Vitalii Krutyi on 21.05.2022.
//

import Foundation

extension APIClient {
    func currentWeather(city: String, appid: String, unit: TemperatureUnit, completion: @escaping APIResponseBlock<CurrentWeatherModel>) {
        let service = APICurrentWeatherService.currentWeather(city: city, appid: appid, unit: unit)
        fetch(service: service, completion: completion)
    }
}
