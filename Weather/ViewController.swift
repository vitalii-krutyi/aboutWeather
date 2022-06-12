//
//  ViewController.swift
//  Weather
//
//  Created by Vitalii Krutyi on 04.05.2022.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIClient.shared.currentWeather(lat: "51.5085", lon: "-0.1257", appid: "9726445297a86d5b2ed46daafbd87bba", completion: { (result) in
            switch result {
            case .success(let response):
                if let data = response.data {
                    print(data.name)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
        
    }
}

