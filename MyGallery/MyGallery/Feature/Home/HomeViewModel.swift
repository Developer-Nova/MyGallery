//
//  HomeViewModel.swift
//  MyGallery
//
//  Created by Nova on 6/8/24.
//

import Foundation

final class HomeViewModel: ObservableObject {
    @Published var selectedTab: Tab
    
    init(selectedTab: Tab = .search) {
        self.selectedTab = selectedTab
    }
}
