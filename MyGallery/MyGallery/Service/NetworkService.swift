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
    
    func fetchPhoto(id: String) -> AnyPublisher<PhotoResponseDTO, NetworkError> {
        let endpoint = UnsplashAPIEndpoints.getPhotoListEndpoint(path: UnsplashAPI.Path.photos(id: id), type: PhotoResponseDTO.self)
            
        return self.networkProvider.request(endpoint: endpoint)
            .eraseToAnyPublisher()
    }
    
    func fetchPhotoList(page: Int = 1, perPage: Int = 30, orderBy: OrderBy = .latest) -> AnyPublisher<[PhotoResponseDTO], NetworkError> {
        let requestDTO = PhotoListRequestDTO(page: page, perPage: perPage, orderBy: orderBy)
        let endpoint = UnsplashAPIEndpoints.getPhotoListEndpoint(query: requestDTO, path: UnsplashAPI.Path.photos(), type: [PhotoResponseDTO].self)
        
        return self.networkProvider.request(endpoint: endpoint)
            .eraseToAnyPublisher()
    }
    
    func fetchSearchPhotoList(about searchText: String, page: Int) -> AnyPublisher<SearchResultResponseDTO, NetworkError> {
        let requestDTO = SearchPhotoListRequestDTO(query: searchText, page: page)
        let endpoint = UnsplashAPIEndpoints.getPhotoListEndpoint(query: requestDTO, path: UnsplashAPI.Path.search, type: SearchResultResponseDTO.self)
        
        return self.networkProvider.request(endpoint: endpoint)
            .eraseToAnyPublisher()
    }
    
    func fetchTopicList() -> AnyPublisher<[TopicResponseDTO], NetworkError> {
        let requestDTO = TopicListRequestDTO()
        let endpoint = UnsplashAPIEndpoints.getPhotoListEndpoint(query: requestDTO, path: UnsplashAPI.Path.topics, type: [TopicResponseDTO].self)
        
        return self.networkProvider.request(endpoint: endpoint)
            .eraseToAnyPublisher()
    }
    
    func fetchTopicPhotoList(id: String, page: Int = 1, perPage: Int = 30, orderBy: OrderBy = .latest) -> AnyPublisher<[PhotoResponseDTO], NetworkError> {
        let requestDTO = PhotoListRequestDTO(page: page, perPage: perPage, orderBy: orderBy)
        let endpoint = UnsplashAPIEndpoints.getPhotoListEndpoint(query: requestDTO, path: UnsplashAPI.Path.topicsPhotos(id: id), type: [PhotoResponseDTO].self)
        
        return self.networkProvider.request(endpoint: endpoint)
            .eraseToAnyPublisher()
    }
    
    func fetchTotalStats() -> AnyPublisher<TotalStatsResponseDTO, NetworkError> {
        let endpoint = UnsplashAPIEndpoints.getPhotoListEndpoint(path: UnsplashAPI.Path.totalStats, type: TotalStatsResponseDTO.self)

        return self.networkProvider.request(endpoint: endpoint)
            .eraseToAnyPublisher()
    }
    
    func fetchMonthStats() -> AnyPublisher<MonthStatsResponseDTO, NetworkError> {
        let endpoint = UnsplashAPIEndpoints.getPhotoListEndpoint(path: UnsplashAPI.Path.monthStats, type: MonthStatsResponseDTO.self)

        return self.networkProvider.request(endpoint: endpoint)
            .eraseToAnyPublisher()
    }
    
    func conversionImage(with urlString: String) -> AnyPublisher<UIImage, NetworkError> {
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
