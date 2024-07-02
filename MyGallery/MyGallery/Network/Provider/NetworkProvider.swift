//
//  NetworkProvider.swift
//  MyGallery
//
//  Created by Nova on 6/4/24.
//
import Foundation
import Combine

final class NetworkProvider: Providable {
    private var session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<R: Decodable, E: RequestResponsable>(endpoint: E) -> AnyPublisher<R, NetworkError> where E.Response == R  {
        guard let urlRequest = try? endpoint.createURLRequest() else {
            return Fail(error: NetworkError.invalidResponse).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.unknown
                }
                
                guard (200...299).contains(httpResponse.statusCode) else {
                    throw NetworkError.badResponse(statusCode: httpResponse.statusCode)
                }
                
                return data
            }
            .decode(type: R.self, decoder: JSONDecoder())
            .mapError { error in
                print(error)
                return NetworkError.decodingFailed
            }
            .eraseToAnyPublisher()
    }
    
    func request(url: URL) -> AnyPublisher<Data, NetworkError> {
        return session.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.unknown
                }
                
                guard (200...299).contains(httpResponse.statusCode) else {
                    throw NetworkError.badResponse(statusCode: httpResponse.statusCode)
                }
                
                return data
            }
            .mapError { error in
                print(error)
                return NetworkError.requestFailed
            }
            .eraseToAnyPublisher()
    }
}
