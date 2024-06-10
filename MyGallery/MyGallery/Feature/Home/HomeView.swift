//
//  HomeView.swift
//  MyGallery
//
//  Created by Nova on 5/31/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var pathModel = Path()
    @StateObject private var homeViewModel = HomeViewModel()
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.customBlack1
    }
    
    var body: some View {
        NavigationStack(path: $pathModel.paths) {
            TabView(selection: $homeViewModel.selectedTab) {
                SearchView()
                    .tabItem {
                        Image(
                            homeViewModel.selectedTab == .search
                            ? "search_selected"
                            : "search"
                        )
                    }
                    .tag(Tab.search)
                
                CollectionView()
                    .tabItem {
                        Image(
                            homeViewModel.selectedTab == .collection
                            ? "collection_selected"
                            : "collection"
                        )
                    }
                    .tag(Tab.collection)
            } //: TabView
        } //: NavigationStack
    }
}

#Preview {
    HomeView()
        .environment(\.backgroundColor, .customBlack0)
}
