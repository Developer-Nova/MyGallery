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

private struct CustomTabBar: View {
    @ObservedObject private var homeViewModel: HomeViewModel
    
    fileprivate init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
    }
    
    fileprivate var body: some View {
        HStack {
            Spacer()
            
            Button (
                action: {
                    homeViewModel.selectedTab = .search
                }, label: {
                    Image(
                        homeViewModel.selectedTab == .search
                        ? "search_selected"
                        : "search"
                    )
                }
            ) //: Button
            
            Spacer()
            
            Button (
                action: {
                    homeViewModel.selectedTab = .collection
                }, label: {
                    Image(
                        homeViewModel.selectedTab == .collection
                        ? "collection_selected"
                        : "collection"
                    )
                }
            ) //: Button
            
            Spacer()
        } //: HStack
        .frame(height: 70)
        .background {
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.white, lineWidth: 1.5)
                .fill(Color.customBlack1)
                .shadow(color: .white.opacity(0.1), radius: 8, y: 1)
        }
        .padding(.horizontal)
    }
}

#Preview {
    HomeView()
        .environment(\.backgroundColor, .customBlack0)
}
