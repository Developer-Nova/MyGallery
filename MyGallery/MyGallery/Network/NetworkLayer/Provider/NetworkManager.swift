//
//  NetworkManager.swift
//  MyGallery
//
//  Created by Nova on 6/2/24.
//

import Foundation

final class NetworkManager: APIClient {
    private let baseURL: URL
    private let session: URLSession
    
    init(baseURL: URL, session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
    }
    
    func request<T>(endpoint: String, method: HTTPMethod = .get, completion: @escaping (Result<T, APIError>) -> Void) where T: Decodable {
        guard let url = URL(string: endpoint, relativeTo: baseURL) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(.failure(.requestFailed))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.unknown))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.badResponse(statusCode: httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            
            guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
                completion(.failure(.decodingFailed))
                return
            }
            
            completion(.success(decodedData))
        }.resume()
    }
}
