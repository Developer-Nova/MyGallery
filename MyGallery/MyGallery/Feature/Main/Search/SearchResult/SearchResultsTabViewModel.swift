//
//  SearchResultsTabViewModel.swift
//  MyGallery
//
//  Created by Nova on 7/19/24.
//

import SwiftUI
import Combine

final class SearchResultsTabViewModel: ObservableObject {
    @Published private(set) var photoList: [Photo]
    @Published private(set) var isLoading: Bool
    @Published var searchText: String
    
    private var currentPage: Int
    private var cancellables: Set<AnyCancellable>
    private let networkService = NetworkService.shared
    
    var photosColumns: [GridItem] {
        Array(repeating: .init(.flexible(), spacing: 3), count: 3)
    }
    
    init(
        photoList: [Photo] = [],
        isLoading: Bool = false,
        searchText: String = "",
        currentPage: Int = 1,
        cancellables: Set<AnyCancellable> = []
    ) {
        self.photoList = photoList
        self.isLoading = isLoading
        self.searchText = searchText
        self.currentPage = currentPage
        self.cancellables = cancellables
    }
}

extension SearchResultsTabViewModel {
    func clearSearchBarAndRemoveAllToPhotoList() {
        self.searchText = ""
        self.currentPage = 1
        self.removeAllToPhotoList()
    }
    
    func morePhotoList() {
        self.currentPage += 1
        
        getSearchPhotoList()
    }
    
    func removeAllToPhotoList() {
        self.photoList.removeAll()
    }
    
    func getSearchPhotoList() {
        self.isLoading.toggle()
        
        networkService.fetchSearchPhotoList(about: searchText, page: currentPage)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                    self.isLoading.toggle()
                }
            } receiveValue: { images in
                withAnimation {
                    self.isLoading.toggle()
                    self.photoList.append(contentsOf: images.map { Photo(image: $0) })
                }
            }
            .store(in: &cancellables)
    }
}
