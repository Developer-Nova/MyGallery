//
//  NetworkService.swift
//  MyGallery
//
//  Created by Nova on 7/2/24.
//

import SwiftUI
import Combine

final class NetworkService {
    static let shared = NetworkService()
    
    private let networkProvider = NetworkProvider()
    
    private init() { }
    
    func fetchNewPhotoList(page: Int = 1, orderBy: OrderBy = .latest, perPage: Int = 30) -> AnyPublisher<[UIImage], NetworkError> {
        let requestDTO = NewPhotoListRequestDTO(page: page, perPage: perPage, orderBy: orderBy)
        let endpoint = UnsplashAPIEndpoints.getPhotoListEndpoint(query: requestDTO, path: UnsplashAPI.Path.photos, type: [PhotoResponseDTO].self)
        
        return self.networkProvider.request(endpoint: endpoint)
            .flatMap { photos in
                Publishers.MergeMany(photos.map { self.conversionImage(with: $0.urls.regular) })
                    .collect()
            }
            .eraseToAnyPublisher()
    }
    
    func fetchSearchPhotoList(about searchText: String, page: Int) -> AnyPublisher<[UIImage], NetworkError> {
        let requestDTO = SearchPhotoListRequestDTO(query: searchText, page: page)
        let endpoint = UnsplashAPIEndpoints.getPhotoListEndpoint(query: requestDTO, path: UnsplashAPI.Path.search, type: SearchResultResponseDTO.self)
        
        return self.networkProvider.request(endpoint: endpoint)
            .flatMap { searchResult -> AnyPublisher<[UIImage], NetworkError> in
                if searchResult.results.isEmpty {
                    return Just([])
                        .setFailureType(to: NetworkError.self)
                        .eraseToAnyPublisher()
                }
                
                return Publishers.MergeMany(searchResult.results.map { self.conversionImage(with: $0.urls.regular)})
                    .collect()
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    private func conversionImage(with urlString: String) -> AnyPublisher<UIImage, NetworkError> {
        guard let url = URL(string: urlString) else {
            return Fail(error: NetworkError.invalidResponse).eraseToAnyPublisher()
        }
     
        return networkProvider.request(url: url)
            .tryMap { data in
                guard let image = UIImage(data: data) else {
                    throw NetworkError.unknown
                }
                
                return image
            }
            .mapError { _ in
                NetworkError.unknown
            }
            .eraseToAnyPublisher()
    }
}
