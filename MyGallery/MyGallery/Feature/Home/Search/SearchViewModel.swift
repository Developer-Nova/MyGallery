//
//  SearchViewModel.swift
//  MyGallery
//
//  Created by Nova on 6/8/24.
//

import SwiftUI
import Combine

final class SearchViewModel: ObservableObject {
    @Published var photoList: [Photo]
    @Published var searchText: String
    @Published private(set) var isLoading: Bool
    @Published private(set) var isInitialAppear: Bool
    
    private(set) var selection: Selection
    private var currentPage: Int
    private var cancellables: Set<AnyCancellable>
    private let networkService = NetworkService.shared
   
    
    var columns: [GridItem] {
        Array(repeating: .init(.flexible(), spacing: 3), count: 3)
    }
    
    init(
        photoList: [Photo] = [Photo](),
        searchText: String = "",
        isLoading: Bool = false,
        isInitialAppear: Bool = true,
        selection: Selection = Selection.newPhoto,
        currentPage: Int = 1,
        cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    ) {
        self.photoList = photoList
        self.searchText = searchText
        self.isLoading = isLoading
        self.isInitialAppear = isInitialAppear
        self.selection = selection
        self.currentPage = currentPage
        self.cancellables = cancellables
    }
}

extension SearchViewModel {
    func changeInitialAppear() {
        self.isInitialAppear.toggle()
    }
    
    func clearSearchBarAndLoadImages() {
        self.searchText = ""
        self.currentPage = 1
        self.photoList.removeAll()
        self.getNewPhotoList()
    }
    
    func morePhotoList(of selection: Selection) {
        self.currentPage += 1
        
        switch selection {
        case .newPhoto:
            getNewPhotoList()
        case .searchPhoto:
            getSearchPhotoList()
        }
    }
    
    func getNewPhotoList() {
        self.isLoading = true
        self.selection = .newPhoto
        
        networkService.fetchNewPhotoList(page: currentPage)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    self.isLoading.toggle()
                case .failure(let error):
                    print(error)
                    self.isLoading.toggle()
                }
            } receiveValue: { images in
                self.photoList.append(contentsOf: images.map { Photo(image: $0) })
            }
            .store(in: &cancellables)
    }
    
    func getSearchPhotoList() {
        self.isLoading = true
        self.selection = .searchPhoto
        
        networkService.fetchSearchPhotoList(about: searchText, page: currentPage)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    self.isLoading.toggle()
                case .failure(let error):
                    print(error)
                    self.isLoading.toggle()
                }
            } receiveValue: { images in
                self.photoList.append(contentsOf: images.map { Photo(image: $0) }) // Todo - photo 객체 수정하기
            }
            .store(in: &cancellables)
    }
}
