//
//  Requestable.swift
//  MyGallery
//
//  Created by Nova on 6/4/24.
//

import Foundation

protocol Requestable {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryParameters: Encodable? { get }
    var bodyParameters: Encodable? { get }
    var headers: [String: String]? { get }
}

extension Requestable {
    func createURLRequest() throws -> URLRequest {
        let url = try createURL()
        var urlRequest = URLRequest(url: url)
        
        if let bodyParameters = try bodyParameters?.toDictionary() {
            if !bodyParameters.isEmpty {
                urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: bodyParameters)
            }
        }
        
        urlRequest.httpMethod = method.rawValue
        
        headers?.forEach { key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        return urlRequest
    }
    
    func createURL() throws -> URL {
        let fullPath = "\(baseURL)\(path)"
        guard var urlComponents = URLComponents(string: fullPath) else { throw URLError.URLcomponentsError }
        
        var urlQueryItems = [URLQueryItem]()
        
        if let queryParameters = try queryParameters?.toDictionary() {
            queryParameters.forEach { key, value in
                urlQueryItems.append(URLQueryItem(name: key, value: "\(value)"))
            }
        }
        
        urlComponents.queryItems = !urlQueryItems.isEmpty ? urlQueryItems : nil
        
        guard let url = urlComponents.url else { throw URLError.isEmpty }
        
        return url
    }
}

