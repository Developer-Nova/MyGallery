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
    @Published private(set) var topicList: [TopicResponseDTO]
    @Published private(set) var isLoading: Bool
    @Published private(set) var isInitialAppear: Bool
    @Published private(set) var popularPhotoTimer: Publishers.Autoconnect<Timer.TimerPublisher>
    @Published private(set) var currentIndex: Int
    
    private var cancellables: Set<AnyCancellable>
    private let nerworkService = NetworkService.shared
    
    var columns: [GridItem] {
        Array(repeating: .init(.flexible(), spacing: 1), count: 2)
    }

    init(
        photoList: [Photo] = [],
        topicList: [TopicResponseDTO] = [],
        isLoading: Bool = false,
        isInitialAppear: Bool = true,
        popularPhotoTimer: Publishers.Autoconnect<Timer.TimerPublisher> = Timer.publish(every: 2, on: .main, in: .common).autoconnect(),
        currentIndex: Int = 0,
        cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    ) {
        self.photoList = photoList
        self.topicList = topicList
        self.isLoading = isLoading
        self.isInitialAppear = isInitialAppear
        self.popularPhotoTimer = popularPhotoTimer
        self.currentIndex = currentIndex
        self.cancellables = cancellables
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
    
    func getPopularPhotoList() {
        self.isLoading.toggle()
        
        self.nerworkService.fetchNewPhotoList(orderBy: .popular, perPage: 15)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                    self.isLoading.toggle()
                }
            } receiveValue: { image in
                withAnimation {
                    self.isLoading.toggle()
                    self.photoList.append(contentsOf: image.map { Photo(image: $0)})
                }
            }
            .store(in: &cancellables)
    }
}
