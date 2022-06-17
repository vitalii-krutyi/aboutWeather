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
    
    var presenter: CurrentWeatherViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.getCurrentWeatherData()
    }
}

extension CurrentWeatherViewController: CurrentWeatherViewProtocol {
    func setCurrentWeather(currentWeather: CurrentWeatherModel) {
        cityButton.isHidden = false
        temperatureLabel.isHidden = false
        descriptionLabel.isHidden = false
        weatherImageView.isHidden = false
        
        cityButton.setTitle(currentWeather.name, for: .normal)
        
        descriptionLabel.text = "   " + (currentWeather.weather.first?.description.capitalized ?? "") + "   "
        descriptionLabel.layer.cornerRadius = 18
        descriptionLabel.clipsToBounds = true
        
        temperatureLabel.text = "\(Int(currentWeather.main.temp)) °"
        weatherImageView.image = UIImage(named: currentWeather.weather.first?.icon ?? "")
    }
}
