//
//  APIResponseEmptyData.swift
//  Weather
//
//  Created by Vitalii Krutyi on 21.05.2022.
//

import Foundation

struct APIResponseEmptyData: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case methodName = "method_name"
        case message
    }
    
    let methodName: String
    let message: String
    
    // MARK: - Codable
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.methodName = try container.decode(String.self, forKey: .methodName)
        self.message = try container.decodeIfPresent(String.self, forKey: .message) ?? ""
    }
    
    public func encode(to encoder: Encoder) throws { }
}
