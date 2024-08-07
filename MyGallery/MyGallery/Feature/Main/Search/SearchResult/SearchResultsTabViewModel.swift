//
//  SearchResultsTabViewModel.swift
//  MyGallery
//
//  Created by Nova on 7/19/24.
//

import SwiftUI
import Combine

final class SearchResultsTabViewModel: ObservableObject {
    @Published private(set) var searchResult: SearchResultResponseDTO
    @Published private(set) var searchPhotoList: [PhotoResponseDTO]
    @Published private(set) var isLoading: Bool
    @Published var searchText: String
    
    private var currentPage: Int
    private var cancellables: Set<AnyCancellable>
    private let networkService = NetworkService.shared
    
    var total: String {
        // Todo - formatter 사용해서 숫자 쉼표 적용하기

        "Total: " + String(self.searchResult.total)
    }
    
    var totalPage: String {
        "Total page: " + String(self.searchResult.totalPages)
    }
    
    var photosColumns: [GridItem] {
        Array(repeating: .init(.flexible(), spacing: 3), count: 3)
    }
    
    init(
        searchResult: SearchResultResponseDTO = .toModel(),
        searchPhotoList: [PhotoResponseDTO] = [],
        isLoading: Bool = false,
        searchText: String = "",
        currentPage: Int = 1,
        cancellables: Set<AnyCancellable> = []
    ) {
        self.searchResult = searchResult
        self.searchPhotoList = searchPhotoList
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
        
        self.getSearchPhotoList()
    }
    
    func removeAllToPhotoList() {
        self.searchPhotoList.removeAll()
    }
    
    func getSearchPhotoList() {
        self.isLoading.toggle()
        
        networkService.fetchSearchPhotoList(about: self.searchText, page: self.currentPage)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                    self.isLoading.toggle()
                }
            } receiveValue: { searchResult in
                withAnimation {
                    self.isLoading.toggle()
                    self.searchResult = searchResult
                    searchResult.results.forEach { self.searchPhotoList.append($0) }
                }
            }
            .store(in: &cancellables)
    }
}
