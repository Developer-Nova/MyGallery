//
//  SearchViewModel.swift
//  MyGallery
//
//  Created by Nova on 6/8/24.
//

import SwiftUI
import Combine

final class SearchViewModel: ObservableObject {
    @Published private(set) var topicList: [TopicResponseDTO]
    @Published private(set) var photoList: [PhotoResponseDTO]
    @Published private(set) var recentSearchText: [String]
    @Published private(set) var isLoading: Bool
    @Published private(set) var isInitialAppear: Bool
    @Published var showDeleteRecentSearchTextDialog: Bool
    @Published var isFocused: Bool
    
    private(set) var selection: Selection
    private var currentPage: Int
    private var topicId: String
    private var cancellables: Set<AnyCancellable>
    private let networkService: NetworkService
    
    var topicsColumns: [GridItem] {
        Array(repeating: .init(.flexible()), count: 2)
    }
    
    var topicsPhotosColumns: [GridItem] {
        Array(repeating: .init(.flexible(), spacing: 3), count: 3)
    }
    
    init(
        topicList: [TopicResponseDTO] = [],
        photoList: [PhotoResponseDTO] = [],
        recentSearchText: [String] = [],
        isLoading: Bool = false,
        isInitialAppear: Bool = true,
        isDeleteRecentSearchText: Bool = false,
        isFocused: Bool = false,
        selection: Selection = .topicView,
        currentPage: Int = 1,
        topicId: String = "",
        cancellables: Set<AnyCancellable> = [],
        networkService: NetworkService = .shared
    ) {
        self.topicList = topicList
        self.photoList = photoList
        self.recentSearchText = recentSearchText
        self.isLoading = isLoading
        self.isInitialAppear = isInitialAppear
        self.showDeleteRecentSearchTextDialog = isDeleteRecentSearchText
        self.isFocused = isFocused
        self.selection = selection
        self.currentPage = currentPage
        self.topicId = topicId
        self.cancellables = cancellables
        self.networkService = networkService
    }
}

extension SearchViewModel {
    func removeAllToPhotoList() {
        self.photoList.removeAll()
    }
    
    func removeAllToRecentSearchText() {
        self.recentSearchText.removeAll()
    }
    
    func changeShowDeleteRecentSearchTextDialog() {
        self.showDeleteRecentSearchTextDialog.toggle()
    }
    
    func addRecentSearchText(to searchText: String) {
        self.recentSearchText.append(searchText)
    }
    
    func changeIsFocused() {
        self.isFocused.toggle()
    }
    
    func changeInitialAppear() {
        self.isInitialAppear.toggle()
    }
    
    func changeSelectionView(by selection: Selection) {
        self.selection = selection
    }
    
    func morePhotoList() {
        self.currentPage += 1
        
        self.getTopicPhotoList()
    }
    
    func setTopicId(id: String) {
        self.topicId = id
    }
    
    func getTopicList() {
        self.isLoading.toggle()
        
        self.networkService.fetchTopicList()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                    self.isLoading.toggle()
                }
            } receiveValue: { topic in
                withAnimation {
                    self.isLoading.toggle()
                    topic.forEach { self.topicList.append($0) }
                }
            }
            .store(in: &cancellables)
    }
    
    func getTopicPhotoList() {
        self.isLoading.toggle()
        
        self.networkService.fetchTopicPhotoList(id: self.topicId, page: self.currentPage)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                    self.isLoading.toggle()
                }
            } receiveValue: { photo in
                withAnimation {
                    self.isLoading.toggle()
                    photo.forEach { self.photoList.append($0) }
                }
            }
            .store(in: &cancellables)
    }
}
