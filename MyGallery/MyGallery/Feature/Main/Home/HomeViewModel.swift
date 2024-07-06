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
    @Published var currentIndex: Int
    
    private var cancellables: Set<AnyCancellable>
    private let nerworkService = NetworkService.shared
    
    init(
        photoList: [Photo] = [],
        isLoading: Bool = false,
        isInitialAppear: Bool = true,
        currentIndex: Int = 0,
        cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    ) {
        self.photoList = photoList
        self.isLoading = isLoading
        self.isInitialAppear = isInitialAppear
        self.currentIndex = currentIndex
        self.cancellables = cancellables
    }
}

extension HomeViewModel {
    func checkTheCountOfPhotoList() -> Int {
        self.photoList.count
    }
    
    func changeInitialAppear() {
        self.isInitialAppear.toggle()
    }
    
    func getPopularPhotoList() {
        self.isLoading.toggle()
        
        self.nerworkService.fetchNewPhotoList(orderBy: .popular)
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
