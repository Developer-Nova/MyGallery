//
//  SearchViewModel.swift
//  MyGallery
//
//  Created by Nova on 6/8/24.
//

import SwiftUI

final class SearchViewModel: ObservableObject {
    @Published var photoList = [Photo]()
    @Published var searchText = ""
    @Published private(set) var isLoading = false
    @Published private(set) var isEmptyImage = false
    
    private let networkProvider = NetworkProvider()
    
    var columns: [GridItem] {
        Array(repeating: .init(.flexible(), spacing: 3), count: 3)
    }
    
    func getNewPhotoList() {
        let endpoint = UnsplashAPIEndpoints.getPhotoListEndpoint(query: PhotoRequestDTO(), path: UnsplashAPI.Path.photos)
        
        networkProvider.request(endpoint: endpoint) { result in
            switch result {
            case .success(let photo):
                DispatchQueue.main.async {
                    self.photoList = photo
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
