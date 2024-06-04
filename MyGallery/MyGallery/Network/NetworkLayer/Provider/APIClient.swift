//
//  APIClient.swift
//  MyGallery
//
//  Created by Nova on 6/2/24.
//

protocol APIClient {
    func request<T: Decodable>(endpoint: String, method: HTTPMethod, completion: @escaping (Result<T, APIError>) -> Void)
}
