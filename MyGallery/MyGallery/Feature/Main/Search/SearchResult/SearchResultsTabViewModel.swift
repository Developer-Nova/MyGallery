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
