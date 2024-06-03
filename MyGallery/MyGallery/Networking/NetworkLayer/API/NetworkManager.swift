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
    
    func sendRequest<T: Decodable>(endpoint: String, method: HTTPMethod, completion: @escaping (Result<[T], APIError>) -> Void) {
        guard let url = URL(string: endpoint, relativeTo: baseURL) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
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
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode([T].self, from: data)
                completion(.success(decodedData))
            } catch let error {
                completion(.failure(.decodingFailed(error)))
            }
        }
        
        task.resume()
    }
}
