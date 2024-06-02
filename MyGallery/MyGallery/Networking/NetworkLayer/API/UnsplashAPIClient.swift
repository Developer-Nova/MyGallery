//
//  UnSplashAPIClient.swift
//  MyGallery
//
//  Created by Nova on 6/2/24.
//

import Foundation

final class UnsplashAPIClient: APIClient {
    private let baseURL: URL
    private let session: URLSession
    
    init(baseURL: URL, session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
    }
    
    func sendRequest<T>(endpoint: String, method: HTTPMethod, completion: @escaping (Result<T, APIError>) -> Void) where T : Decodable {
        guard let url = URL(string: endpoint, relativeTo: baseURL) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed))
                return
            }
            
            guard let response = response else { return }
            
            // todo: 각 response 처리 필요
            
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingFailed))
            }
        }
        
        task.resume()
    }
}
