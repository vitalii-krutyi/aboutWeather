//
//  CurrentWeatherPresenter.swift
//  Weather
//
//  Created by Vitalii Krutyi on 13.06.2022.
//

import Foundation

protocol CurrentWeatherViewProtocol: AnyObject {
    func setCurrentWeather(currentWeather: CurrentWeatherModel)
}

protocol CurrentWeatherViewPresenterProtocol: AnyObject {
    init(view: CurrentWeatherViewProtocol)
    func getCurrentWeatherData()
    func showCurrentWeather()
    func convertSpeedWind(speed: Double) -> String
}

class CurrentWeatherPresenter: CurrentWeatherViewPresenterProtocol {
    let view: CurrentWeatherViewProtocol
    var currentWeatherData: CurrentWeatherModel?
    
    required init(view: CurrentWeatherViewProtocol) {
        self.view = view
    }
    
    func getCurrentWeatherData() {
        APIClient.shared.currentWeather(city: "Lviv", appid: "9726445297a86d5b2ed46daafbd87bba", unit: .celsius, completion: { (result) in
            switch result {
            case .success(let response):
                if let data = response.data {
                    self.currentWeatherData = data
                    self.showCurrentWeather()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func showCurrentWeather() {
        if let data = currentWeatherData {
            self.view.setCurrentWeather(currentWeather: data)
        }
    }
}

extension CurrentWeatherPresenter {
    func convertSpeedWind(speed: Double) -> String {
        return String(format: "%.1f", speed * 3.6)
    }
}
