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
        
    }
}
