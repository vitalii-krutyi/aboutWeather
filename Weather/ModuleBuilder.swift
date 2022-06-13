//
//  ModuleBuilder.swift
//  Weather
//
//  Created by Vitalii Krutyi on 13.06.2022.
//

import Foundation

import UIKit

protocol Builder {
    static func createCurrentWeatherModule() -> UIViewController
}

class ModelBuilder: Builder {
    static func createCurrentWeatherModule() -> UIViewController {
        let view = CurrentWeatherViewController()
        let presenter = CurrentWeatherPresenter(view: view)
        view.presenter = presenter
        
        return view
    }
}
