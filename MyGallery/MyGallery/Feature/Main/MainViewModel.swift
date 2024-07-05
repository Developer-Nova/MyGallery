//
//  MainViewModel.swift
//  MyGallery
//
//  Created by Nova on 6/8/24.
//

import Foundation

final class MainViewModel: ObservableObject {
    @Published var selectedTab: Tab
    @Published var showSplashView: Bool
    
    init(
        selectedTab: Tab = .home,
        showSplashView: Bool = false
    ) {
        self.selectedTab = selectedTab
        self.showSplashView = showSplashView
    }
}
