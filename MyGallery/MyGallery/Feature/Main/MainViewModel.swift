//
//  MainViewModel.swift
//  MyGallery
//
//  Created by Nova on 6/8/24.
//

import Foundation

final class MainViewModel: ObservableObject {
    @Published var selectedTab: Tab
    @Published private(set) var showSplashView: Bool
    
    init(
        selectedTab: Tab = .home,
        showSplashView: Bool = true
    ) {
        self.selectedTab = selectedTab
        self.showSplashView = showSplashView
    }
}

extension MainViewModel {
    func changeShowSplashView() {
        self.showSplashView.toggle()
    }
}
