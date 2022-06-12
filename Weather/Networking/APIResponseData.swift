//
//  APIResponseData.swift
//  Weather
//
//  Created by Vitalii Krutyi on 21.05.2022.
//

import Foundation

struct APIResponseData<T: Codable>: Codable {
    let data: T?
    
    // MARK: - Codable
    
    public init(from decoder: Decoder) throws {
        let currentWeatherData = try CurrentWeatherModel(from: decoder)
        self.data = currentWeatherData as? T
    }
    
    public func encode(to encoder: Encoder) throws { }
}
