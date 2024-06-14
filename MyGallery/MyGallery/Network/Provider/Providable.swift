//
//  Providable.swift
//  MyGallery
//
//  Created by Nova on 6/4/24.
//
import Foundation

protocol Providable {
    func request<R: Decodable, E: RequestResponsable>(endpoint: E, completion: @escaping (Result<R, NetworkError>) -> Void) where E.Response == R
}
