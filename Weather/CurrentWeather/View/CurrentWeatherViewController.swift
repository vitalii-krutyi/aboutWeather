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
    @IBOutlet var pickDownButton: UIView!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var presenter: CurrentWeatherViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.getCurrentWeatherData()
    }
    
    // MARK: - IBAction -
    @IBAction func didPressedPickDownButton(_ sender: UIButton) {
        
    }
}

extension CurrentWeatherViewController: CurrentWeatherViewProtocol {
    func setCurrentWeather(currentWeather: CurrentWeatherModel) {
        descriptionLabel.text = currentWeather.weather.first?.description
        temperatureLabel.text = "\(currentWeather.main.temp)"
    }
}
