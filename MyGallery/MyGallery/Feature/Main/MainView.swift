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
                    } //: Group
                    .toolbarBackground(.hidden, for: .tabBar)
                } //: TabView
                .environmentObject(pathModel)
                .environmentObject(mainViewModel)
                .navigationDestination(for: PathType.self) { path in
                    switch path {
                    case .photoDescriptionView(let photo):
                        PhotoDescriptionView(photo: photo)
                            .navigationBarBackButtonHidden()
                    case .searchPhotoView:
                        SearchView()
                            .navigationBarBackButtonHidden()
                    }
                }
                
                VStack {
                    Spacer()
                    
                    CustomTabBarView(mainViewModel: mainViewModel)
                        .padding(.bottom, -4)
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
                    .resizable()
                    .frame(width: 30, height: 30)
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
                    .resizable()
                    .frame(width: 30, height: 30)
                }) //: Button
            
            Spacer()
        } //: HStack
        .frame(height: 60)
        .background {
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.gray, lineWidth: 1.0)
                .fill(Color.customBlack1)
        }
        .padding(.horizontal)
    }
}

#Preview {
    MainView()
        .environment(\.backgroundColor, .customBlack0)
}
