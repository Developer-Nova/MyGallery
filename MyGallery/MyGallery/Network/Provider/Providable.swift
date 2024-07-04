//
//  Providable.swift
//  MyGallery
//
//  Created by Nova on 6/4/24.
//
import Foundation
import Combine

protocol Providable {
    func request<R: Decodable, E: RequestResponsable>(endpoint: E) -> AnyPublisher<R, NetworkError> where E.Response == R
    
    func request(url: URL) -> AnyPublisher<Data, NetworkError>
}
