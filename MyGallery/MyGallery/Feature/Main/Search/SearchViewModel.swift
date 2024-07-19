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
    @Published private(set) var recentSearchText: [String]
    @Published private(set) var isLoading: Bool
    @Published private(set) var isInitialAppear: Bool
    @Published var showDeleteRecentSearchTextDialog: Bool
    @Published var isFocused: Bool
    
    private(set) var selection: Selection
    private var currentPage: Int
    private var cancellables: Set<AnyCancellable>
    private let networkService = NetworkService.shared
    
    var topicsColumns: [GridItem] {
        Array(repeating: .init(.flexible()), count: 2)
    }
    
    init(
        topicList: [TopicResponseDTO] = [],
        recentSearchText: [String] = [],
        isLoading: Bool = false,
        isInitialAppear: Bool = true,
        isDeleteRecentSearchText: Bool = false,
        isFocused: Bool = false,
        selection: Selection = .topicView,
        currentPage: Int = 1,
        cancellables: Set<AnyCancellable> = []
    ) {
        self.topicList = topicList
        self.recentSearchText = recentSearchText
        self.isLoading = isLoading
        self.isInitialAppear = isInitialAppear
        self.showDeleteRecentSearchTextDialog = isDeleteRecentSearchText
        self.isFocused = isFocused
        self.selection = selection
        self.currentPage = currentPage
        self.cancellables = cancellables
    }
}

extension SearchViewModel {
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
                    self.topicList.append(contentsOf: topic)
                }
            }
            .store(in: &cancellables)
    }
}
