//
//  SearchViewModel.swift
//  MyGallery
//
//  Created by Nova on 6/8/24.
//

import SwiftUI
import Combine

final class SearchViewModel: ObservableObject {
    @Published var photoList = [Photo]()
    @Published var searchText = ""
    @Published private(set) var isLoading = false
    @Published private(set) var isEmptyImage = false
    
    private let networkProvider = NetworkProvider()
    private var cancellables = Set<AnyCancellable>()
    
    var columns: [GridItem] {
        Array(repeating: .init(.flexible(), spacing: 3), count: 3)
    }
    
    func getNewPhotoList() {
        let requestDTO = NewPhotoListRequestDTO()
        let endpoint = UnsplashAPIEndpoints.getPhotoListEndpoint(query: requestDTO, path: UnsplashAPI.Path.photos, type: [PhotoResponseDTO].self)
        
        self.isLoading = true
        self.networkProvider.request(endpoint: endpoint)
            .flatMap { photos in
                Publishers.MergeMany(photos.map { self.conversionImage(with: $0.urls.small) })
                    .collect()
            }
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    self.isLoading = false
                case .failure(let error):
                    print(error)
                    self.isLoading = false
                }
            } receiveValue: { images in
                self.photoList = images.map { Photo(image: $0) }
            }
            .store(in: &cancellables)
    }
    
    func getSearchPhotoList() {
        let requestDTO = SearchPhotoListRequestDTO(query: searchText)
        let endpoint = UnsplashAPIEndpoints.getPhotoListEndpoint(query: requestDTO, path: UnsplashAPI.Path.search, type: SearchResultResponseDTO.self)
        
        self.isLoading = true
        self.networkProvider.request(endpoint: endpoint)
            .receive(on: DispatchQueue.main)
            .flatMap { searchResult -> AnyPublisher<[UIImage], NetworkError> in
                if searchResult.results.isEmpty {
                    self.isEmptyImage = true
                    return Just([])
                        .setFailureType(to: NetworkError.self)
                        .eraseToAnyPublisher()
                }
                
                self.isEmptyImage = false
                
                return Publishers.MergeMany(searchResult.results.map { self.conversionImage(with: $0.urls.small)})
                    .collect()
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    self.isLoading = false
                case .failure(let error):
                    print(error)
                    self.isLoading = false
                }
            } receiveValue: { images in
                self.photoList = images.map { Photo(image: $0) }
            }
            .store(in: &cancellables)
    }
    
    private func conversionImage(with urlString: String) -> AnyPublisher<UIImage, NetworkError> {
        guard let url = URL(string: urlString) else {
            return Fail(error: NetworkError.invalidResponse).eraseToAnyPublisher()
        }
     
        return networkProvider.request(url: url)
            .tryMap { data in
                guard let image = UIImage(data: data) else {
                    throw NetworkError.invalidResponse
                }
                
                return image
            }
            .mapError { _ in
                NetworkError.unknown
            }
            .eraseToAnyPublisher()
    }
}
