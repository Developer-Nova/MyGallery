//
//  HomeViewModel.swift
//  MyGallery
//
//  Created by Nova on 7/4/24.
//

import SwiftUI
import Combine

final class HomeViewModel: ObservableObject {
    @Published private(set) var photoList: [PhotoResponseDTO]
    @Published private(set) var isLoading: Bool
    @Published private(set) var isInitialAppear: Bool
    
    private var currentPage: Int
    private var cancellables: Set<AnyCancellable>
    private let networkService: NetworkService
    
    var photosColumns: [GridItem] {
        Array(repeating: .init(.flexible(), spacing: 3), count: 2)
    }

    init(
        photoList: [PhotoResponseDTO] = [],
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
    func isPhotoListEmpty() -> Bool {
        self.photoList.isEmpty
    }
    
    func changeInitialAppear() {
        self.isInitialAppear.toggle()
    }
    
    func morePhotoList() {
        self.currentPage += 1
        
        getPopularPhotoList()
    }
    
    func getPopularPhotoList() {
        self.isLoading.toggle()
        
        self.networkService.fetchPhotoList(page: self.currentPage, orderBy: .latest)
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
