//
//  APIError.swift
//  MyGallery
//
//  Created by Nova on 6/2/24.
//

enum APIError: Error {
    case invalidURL
    case requestFailed
    case invalidResponse
    case decodingFailed
    case badResponse(statusCode: Int)
    case unknown
}
