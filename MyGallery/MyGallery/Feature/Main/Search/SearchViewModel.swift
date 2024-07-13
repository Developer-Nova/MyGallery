//
//  SearchViewModel.swift
//  MyGallery
//
//  Created by Nova on 6/8/24.
//

import SwiftUI
import Combine

final class SearchViewModel: ObservableObject {
    @Published private(set) var photoList: [Photo]
    @Published private(set) var isLoading: Bool
    @Published private(set) var isInitialAppear: Bool
    @Published  var isFocused: Bool
    @Published var searchText: String
    
    private(set) var selection: Selection
    private var currentPage: Int
    private var cancellables: Set<AnyCancellable>
    private let networkService = NetworkService.shared
   
    
    var columns: [GridItem] {
        Array(repeating: .init(.flexible(), spacing: 3), count: 3)
    }
    
    init(
        photoList: [Photo] = [Photo](),
        isLoading: Bool = false,
        isInitialAppear: Bool = true,
        isFocused: Bool = false,
        searchText: String = "",
        selection: Selection = Selection.newPhoto,
        currentPage: Int = 1,
        cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    ) {
        self.photoList = photoList
        self.isLoading = isLoading
        self.isInitialAppear = isInitialAppear
        self.isFocused = isFocused
        self.searchText = searchText
        self.selection = selection
        self.currentPage = currentPage
        self.cancellables = cancellables
    }
}

extension SearchViewModel {
    func changeIsFocused() {
        self.isFocused.toggle()
    }
    
    func removeAllToPhotoList() {
        self.photoList.removeAll()
    }
    
    func changeInitialAppear() {
        self.isInitialAppear.toggle()
    }
    
    func clearSearchBarAndLoadImages() {
        self.searchText = ""
        self.currentPage = 1
        self.removeAllToPhotoList()
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
        self.isLoading.toggle()
        self.selection = .newPhoto
        
        networkService.fetchNewPhotoList(page: currentPage)
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
    
    func getSearchPhotoList() {
        self.isLoading.toggle()
        self.selection = .searchPhoto
        
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
    
    //    private func getTopicList() -> AnyPublisher<[TopicResponseDTO], NetworkError> {
    //        self.nerworkService.fetchTopicList()
    //            .eraseToAnyPublisher()
    //    }
}
