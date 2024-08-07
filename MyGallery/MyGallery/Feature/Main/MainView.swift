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
    @StateObject private var searchViewModel = SearchViewModel()
    
    var body: some View {
        if !mainViewModel.showSplashView {
            MainContentView(mainViewModel: mainViewModel)
                .environmentObject(pathModel)
                .environmentObject(searchViewModel)
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
                    } //: Group
                    .toolbarBackground(.hidden, for: .tabBar)
                } //: TabView
                .environmentObject(pathModel)
                .navigationDestination(for: PathType.self) { path in
                    switch path {
                    case .photoDescriptionView(let photoObject, let image):
                        PhotoDescriptionView(photo: photoObject, image: image)
                            .navigationBarBackButtonHidden()
                    case .searchPhotoView:
                        SearchView()
                            .navigationBarBackButtonHidden()
                    case .topicPhotoScrollView(let title):
                        TopicPhotoScrollView(topicTitle: title)
                            .navigationBarBackButtonHidden()
                    }
                }
                
                VStack {
                    Spacer()
                    
                    CustomTabBarView(mainViewModel: mainViewModel)
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
        VStack {
            Divider()
                .frame(height: 0.7)
                .background(.white.opacity(0.5))
            
            HStack {
                Spacer()
                
                Button (action: {
                    mainViewModel.selectedTab = .home
                }, label: {
                    VStack {
                        Image(
                            mainViewModel.selectedTab == .home
                            ? "home_selected"
                            : "home"
                        )
                        .resizable()
                        .frame(width: 23, height: 23)
                        
                        Text("Home")
                            .font(.system(size: 10))
                            .foregroundStyle(
                                mainViewModel.selectedTab == .home
                                ? .white
                                : .white.opacity(0.5)
                            )
                    } //: VStack
                }) //: Button
                
                Spacer()
                
                Button (action: {
                    mainViewModel.selectedTab = .search
                }, label: {
                    VStack {
                        Image(
                            mainViewModel.selectedTab == .search
                            ? "search_selected"
                            : "search"
                        )
                        .resizable()
                        .frame(width: 23, height: 23)
                        
                        Text("Search")
                            .font(.system(size: 10))
                            .foregroundStyle(
                                mainViewModel.selectedTab == .search
                                ? .white
                                : .white.opacity(0.5)
                            )
                    } //: VStack
                }) //: Button
                
                Spacer()
            } //: HStack
            .frame(height: 40)
        } //: VStack
        .background(.customBlack1)
    }
}

#Preview {
    MainView()
        .environment(\.backgroundColor, .customBlack0)
}
