//
//  Provider.swift
//  MyGallery
//
//  Created by Nova on 6/4/24.
//

protocol Provider {
    func request<R: Decodable, E: RequestResponsable>(endpoint: E, completion: @escaping (Result<R, APIError>) -> Void) where E.Response == R
}
