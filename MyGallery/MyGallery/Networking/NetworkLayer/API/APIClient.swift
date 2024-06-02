//
//  APIClient.swift
//  MyGallery
//
//  Created by Nova on 6/2/24.
//

import Foundation

protocol APIClient {
    func sendRequest<T: Decodable>(endpoint: String, method: HTTPMethod, completion: @escaping (Result<T, APIError>) -> Void)
}
