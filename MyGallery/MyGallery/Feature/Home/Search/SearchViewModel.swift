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
    
    private let networkService = NetworkService.shared
    private var cancellables = Set<AnyCancellable>()
    
    var columns: [GridItem] {
        Array(repeating: .init(.flexible(), spacing: 3), count: 3)
    }
    
    func clearSearchBarAndLoadImages() {
        self.searchText = ""
        self.isEmptyImage = false
    }
    
    func getNewPhotoList() {
        self.isLoading = true
        
        networkService.getNewPhotoList()
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
        self.isLoading = true
        
        networkService.getSearchPhotoList(about: searchText)
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
                guard !images.isEmpty else {
                    self.isEmptyImage = true
                    return
                }
                
                self.isEmptyImage = false
                self.photoList = images.map { Photo(image: $0) } // Todo - photo 객체 수정하기
            }
            .store(in: &cancellables)
    }
}
