//
//  HomeViewModel.swift
//  MyGallery
//
//  Created by Nova on 7/4/24.
//

import SwiftUI
import Combine

final class HomeViewModel: ObservableObject {
    @Published private(set) var photoList: [Photo]
    @Published private(set) var isLoading: Bool
    @Published private(set) var isInitialAppear: Bool
    
    private var currentPage: Int
    private var cancellables: Set<AnyCancellable>
    private let networkService: NetworkService
    
    var columns: [GridItem] {
        Array(repeating: .init(.flexible(), spacing: 3), count: 2)
    }

    init(
        photoList: [Photo] = [],
        isLoading: Bool = false,
        isInitialAppear: Bool = true,
        currentPage: Int = 1,
        cancellables: Set<AnyCancellable> = Set<AnyCancellable>(),
        networkService: NetworkService = .shared
    ) {
        self.photoList = photoList
        self.isLoading = isLoading
        self.isInitialAppear = isInitialAppear
        self.currentPage = currentPage
        self.cancellables = cancellables
        self.networkService = networkService
    }
}

extension HomeViewModel {
    func cyclePhotoListIndex() {
        self.currentIndex = (self.currentIndex + 1) % self.checkTheCountOfPhotoList()
    }
    
    func checkTheCountOfPhotoList() -> Int {
        self.photoList.count
    }
    
    func changeInitialAppear() {
        self.isInitialAppear.toggle()
    }
    
    func getPopularPhotosAndTopics() {
        self.isLoading.toggle()
        
        Publishers.CombineLatest(self.getPopularPhotoList(), self.getTopicList())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                    self.isLoading.toggle()
                }
            } receiveValue: { image, topic in
                withAnimation {
                    self.isLoading.toggle()
                    self.photoList.append(contentsOf: image.map { Photo(image: $0)})
                    self.topicList.append(contentsOf: topic)
                }
            }
            .store(in: &cancellables)
    }
    
    private func getPopularPhotoList() -> AnyPublisher<[UIImage], NetworkError> {
        self.nerworkService.fetchNewPhotoList(orderBy: .latest, perPage: 15)
            .eraseToAnyPublisher()
    }
    
    private func getTopicList() -> AnyPublisher<[TopicResponseDTO], NetworkError> {
        self.nerworkService.fetchTopicList()
            .eraseToAnyPublisher()
    }
}
