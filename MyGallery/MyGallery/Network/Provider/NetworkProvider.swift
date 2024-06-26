//
//  NetworkProvider.swift
//  MyGallery
//
//  Created by Nova on 6/4/24.
//

import Foundation

final class NetworkProvider: Providable {
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<R: Decodable, E: RequestResponsable>(endpoint: E, completion: @escaping (Result<R, NetworkError>) -> Void) where E.Response == R  {
        guard let urlRequest = try? endpoint.createURLRequest() else {
            completion(.failure(.requestFailed))
            return
        }
        
        session.dataTask(with: urlRequest) { data, response, error in
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
                completion(.failure(.emptyData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(R.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(NetworkError.decodingFailed))
            }
            
        }.resume()
    }
}
