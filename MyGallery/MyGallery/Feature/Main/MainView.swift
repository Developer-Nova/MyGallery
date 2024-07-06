//
//  MainView.swift
//  MyGallery
//
//  Created by Nova on 5/31/24.
//

import SwiftUI

struct MainView: View {
    @StateObject private var pathModel = Path()
    @StateObject private var mainViewModel = MainViewModel()
    
    init() {
        UITabBar.appearance().backgroundImage = UIImage()
    }
    
    var body: some View {
        if !mainViewModel.showSplashView {
            MainContentView(mainViewModel: mainViewModel)
                .environmentObject(pathModel)
        } else {
            SplashView()
                .transition(.opacity)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            mainViewModel.changeShowSplashView()
                        }
                    }
                }
        } //: if Condition
    }
}

// MARK: - NavigationStackAndTabView
private struct MainContentView: View {
    @EnvironmentObject private var pathModel: Path
    @ObservedObject private var mainViewModel: MainViewModel
    
    fileprivate init(mainViewModel: MainViewModel) {
        self.mainViewModel = mainViewModel
    }
    
    fileprivate var body: some View {
        NavigationStack(path: $pathModel.paths) {
            ZStack {
                TabView(selection: $mainViewModel.selectedTab) {
                    Group {
                        HomeView()
                            .tag(Tab.home)
                        
                        SearchView()
                            .tag(Tab.search)
                        
                        CollectionView()
                            .tag(Tab.collection)
                    } //: Group
                    .toolbar(.hidden, for: .tabBar)
                } //: TabView
                .environmentObject(pathModel)
                .environmentObject(mainViewModel)
                .navigationDestination(for: PathType.self) { path in
                    switch path {
                    case .photoDescriptionView(let photo):
                        PhotoDescriptionView(photo: photo)
                    }
                }
                
                VStack {
                    Spacer()
                    
                    CustomTabBarView(mainViewModel: mainViewModel)
                        .padding(.bottom, -10)
                } //: VStack
            } //: ZStack
            .ignoresSafeArea(.keyboard)
        } //: NavigationStack
    }
}


// MARK: - CustomTabBar
private struct CustomTabBarView: View {
    @ObservedObject private var mainViewModel: MainViewModel
    
    fileprivate init(mainViewModel: MainViewModel) {
        self.mainViewModel = mainViewModel
    }
    
    fileprivate var body: some View {
        HStack {
            Spacer()
            
            Button (action: {
                    mainViewModel.selectedTab = .home
                }, label: {
                    Image(
                        mainViewModel.selectedTab == .home
                        ? "home_selected"
                        : "home"
                    )
                }) //: Button
            
            Spacer()
            
            Button (action: {
                    mainViewModel.selectedTab = .search
                }, label: {
                    Image(
                        mainViewModel.selectedTab == .search
                        ? "search_selected"
                        : "search"
                    )
                }) //: Button
            
            Spacer()
            
            Button (action: {
                    mainViewModel.selectedTab = .collection
                }, label: {
                    Image(
                        mainViewModel.selectedTab == .collection
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
    MainView()
        .environment(\.backgroundColor, .customBlack0)
}
