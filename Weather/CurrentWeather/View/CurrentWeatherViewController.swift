//
//  CurrentWeatherViewController.swift
//  Weather
//
//  Created by Vitalii Krutyi on 13.06.2022.
//

import UIKit

class CurrentWeatherViewController: UIViewController {
    
    //MARK:  - IBOutlets -
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var cityButton: UIButton!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var probabilityOfRainLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var speedOfWindLabel: UILabel!
    
    var presenter: CurrentWeatherViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.getCurrentWeatherData()
    }
}

extension CurrentWeatherViewController: CurrentWeatherViewProtocol {
    func setCurrentWeather(currentWeather: CurrentWeatherModel) {
        cityButton.setTitle(currentWeather.name, for: .normal)
        cityButton.isHidden = false
        
        descriptionLabel.text = "   " + (currentWeather.weather.first?.description.capitalized ?? "") + "   "
        descriptionLabel.isHidden = false
        descriptionLabel.layer.cornerRadius = 18
        descriptionLabel.clipsToBounds = true
        
        temperatureLabel.text = "\(Int(currentWeather.main.temp)) °"
        temperatureLabel.isHidden = false
        
        weatherImageView.image = UIImage(named: currentWeather.weather.first?.icon ?? "")
        weatherImageView.isHidden = false
        
        probabilityOfRainLabel.text = "\(currentWeather.main.humidity)%"
        pressureLabel.text = "\(currentWeather.main.pressure) Bar"
        speedOfWindLabel.text = "\(presenter.convertSpeedWind(speed: currentWeather.wind.speed)) km/h"
    }
}
