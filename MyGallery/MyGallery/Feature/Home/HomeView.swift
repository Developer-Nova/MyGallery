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
        UITabBar.appearance().backgroundImage = UIImage()
    }
    
    var body: some View {
        NavigationStack(path: $pathModel.paths) {
            ZStack {
                TabView(selection: $homeViewModel.selectedTab) {
                    Group {
                        SearchView()
                            .tag(Tab.search)
                        
                        CollectionView()
                            .tag(Tab.collection)
                    } //: Group
                    .toolbar(.hidden, for: .tabBar)
                } //: TabView
                .environmentObject(pathModel)
                .environmentObject(homeViewModel)
                .navigationDestination(for: PathType.self) { path in
                    switch path {
                    case .photoDescriptionView(let photo):
                        PhotoDescriptionView(photo: photo) // Todo - photo 객체 넘겨주기

                        // Todo - homeView 의 이미지를 선택했을때도 photo 객체 넘겨주기 DetailView 를 재사용하기 위함
                    }
                }
                
                VStack {
                    Spacer()
                    
                    CustomTabBar(homeViewModel: homeViewModel)
                        .padding(.bottom, -10)
                } //: VStack
            } //: ZStack
            .ignoresSafeArea(.keyboard)
        } //: NavigationStack
    }
}


// MARK: - CustomTabBar
private struct CustomTabBar: View {
    @ObservedObject private var homeViewModel: HomeViewModel
    
    fileprivate init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
    }
    
    fileprivate var body: some View {
        HStack {
            Spacer()
            
            Button (action: {
                    homeViewModel.selectedTab = .search
                }, label: {
                    Image(
                        homeViewModel.selectedTab == .search
                        ? "search_selected"
                        : "search"
                    )
                }) //: Button
            
            Spacer()
            
            Button (action: {
                    homeViewModel.selectedTab = .collection
                }, label: {
                    Image(
                        homeViewModel.selectedTab == .collection
                        ? "collection_selected"
                        : "collection"
                    )
                }) //: Button
            
            Spacer()
        } //: HStack
        .frame(height: 70)
        .background {
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.white, lineWidth: 1.5)
                .fill(Color.customBlack1)
                .shadow(color: .white.opacity(0.5), radius: 4, y: 1)
        }
        .padding(.horizontal)
    }
}

#Preview {
    HomeView()
        .environment(\.backgroundColor, .customBlack0)
}
