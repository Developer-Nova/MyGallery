//
//  MainViewModel.swift
//  MyGallery
//
//  Created by Nova on 6/8/24.
//

import Foundation

final class MainViewModel: ObservableObject {
    @Published var selectedTab: Tab
    
    init(selectedTab: Tab = .search) {
        self.selectedTab = selectedTab
    }
}
