//
//  APIClient.swift
//  Weather
//
//  Created by Vitalii Krutyi on 21.05.2022.
//

import Foundation
import Alamofire

enum APIEnvironment: String {
    case DEV
    case STAGING
    case PROD
    
    static var current: APIEnvironment = {
        guard let envString = UserDefaults.standard.string(forKey: "environmentString"),
              let env = APIEnvironment(rawValue: envString) else {
            return .PROD
        }
        
        return env
    }()
    
    var url: String {
        switch self {
        case .DEV: return APIConstants.devUrl
        case .STAGING: return APIConstants.stageUrl
        case .PROD: return APIConstants.prodUrl
        }
    }
}

struct APIConstants {
    static let devUrl = "https://api.openweathermap.org/data/2.5/"
    static let stageUrl = "https://api.openweathermap.org/data/2.5/"
    static let prodUrl = "https://api.openweathermap.org/data/2.5/"
}

typealias APIResponseBlock<T: Codable> = (Result<APIResponseData<T>, Error>) -> Void
typealias APIResponseEmptyBlock = (Result<APIResponseEmptyData, Error>) -> Void

enum APIServiceError: Error {
    case cantCreateRequest
    case multipartFromDataIsMissed
}

enum EncodingType {
    case url
    case json
    case query
}

protocol APIMultipartFormDataProtocol {
    var multipartFormData: MultipartFormData? { get }
}

protocol APIBaseServiceProtocol: URLRequestConvertible {
    var baseURL: URL { get }
    var parameters: Parameters? { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var encoding: EncodingType { get }
    var headers: HTTPHeaders? { get }
}

extension APIBaseServiceProtocol {
    var baseURL: URL { URL(string: APIEnvironment.current.url)! }
    
    var headers: HTTPHeaders? { nil }
    
    func asURLRequest() throws -> URLRequest {
        let urlString = baseURL.appendingPathComponent(path)
        
        guard let correctURL = urlString.absoluteString.removingPercentEncoding,
              let url = URL(string: correctURL) else {
            throw APIServiceError.cantCreateRequest
        }
        
        var request = URLRequest(url: url)
        request.method = method
        
        if let headers = headers {
            request.headers = headers
        }
        
        switch encoding {
        case .json:
            request = try JSONEncoding.default.encode(request, with: parameters)
        case .query:
            request = try URLEncoding(destination: .httpBody).encode(request, with: parameters)
        case .url:
            request = try URLEncoding.default.encode(request, with: parameters)
        }
        
        return request
    }
}

final class APIClient: APIClientProtocol {
    static let shared: APIClientProtocol = APIClient()
    
    func fetch<T: Decodable>(service: APIBaseServiceProtocol, completion: @escaping (Result<T, Error>) -> Void) {
        Self.logRequestInfo(service: service)
        AF.request(service).responseDecodable(of: T.self) { response in
            Self.logResponseInfo(callback: response)
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    typealias UploadService = APIBaseServiceProtocol & APIMultipartFormDataProtocol
    func upload<T: Decodable>(service: UploadService, completion: @escaping (Result<T, Error>) -> Void) {
        Self.logRequestInfo(service: service)
        
        guard let multipartFormData = service.multipartFormData else {
            completion(.failure(APIServiceError.multipartFromDataIsMissed))
            return
        }
        
        AF.upload(multipartFormData: multipartFormData, with: service)
            .responseDecodable(of: T.self) { response in
                Self.logResponseInfo(callback: response)
                switch response.result {
                case .success(let result):
                    completion(.success(result))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    static private func logRequestInfo(service: APIBaseServiceProtocol) {
#if DEBUG
        guard let url = service.urlRequest?.url,
              let parameters = service.parameters else {
            return
        }
        
        print("\n>>>>>>>>>>>")
        print("parameters for url - \(url): ", parameters)
        print(">>>>>>>>>>>")
#endif
    }
    
    static private func logResponseInfo<T: Decodable>(callback: DataResponse<T, AFError>) {
#if DEBUG
        if let data = callback.data {
            if let url = callback.request?.url,
               let JSONString = String(data: data, encoding: String.Encoding.utf8) {
                print("\n>>>>>>>>>>>")
                print("request: \(url), response: \(JSONString)")
                print(">>>>>>>>>>>")
            }
        }
#endif
    }
}
