//
//  HomeView.swift
//  MyGallery
//
//  Created by Nova on 7/4/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var pathModel: Path
    @StateObject private var homeViewModel = HomeViewModel()
    
    var body: some View {
        if !homeViewModel.isLoading {
            HomeContentView(homeViewModel: homeViewModel)
        } else {
            CustomProgressView()
        } //: if Condition
    }
}

// MARK: - HomeContentView
private struct HomeContentView: View {
    @ObservedObject private var homeViewModel: HomeViewModel
    
    fileprivate init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
    }
    
    fileprivate var body: some View {
        ScrollView {
            TitleView()

            PopularPhotoTabVeiw(homeViewModel: homeViewModel)
            
            Spacer()
        } //: ScrollView
        .onAppear {
            if homeViewModel.isInitialAppear {
                homeViewModel.getPopularPhotoList()
                homeViewModel.changeInitialAppear()
            }
        }
        .applyBackgroundColor()
    }
}

// MARK: - TitleView
private struct TitleView: View {
    @EnvironmentObject private var pathModel: Path
    
    fileprivate init() { }
    
    fileprivate var body: some View {
        VStack {
            HStack {
                Text("My")
                    .strikethrough()
                
                Text("Gallery")
                
                Spacer()
                
                Button (action: {
                    pathModel.paths.append(.searchPhotoView)
                },
                 label: {
                    Image("search")
                        .resizable()
                        .frame(width: 25, height: 25)
                    
                }) //: Button
                .padding(.trailing, 7)
            } //: HStack
            .font(.system(size: 30, weight: .bold))
            .fontWeight(.bold)
            .foregroundStyle(Color.white)
            .padding(.horizontal)
        } //: VStack
        .padding(.top, 10)
    }
}

// MARK: - PopularPhotoContentView
private struct PopularPhotoTabVeiw: View {
    @ObservedObject private var homeViewModel: HomeViewModel
    
    fileprivate init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            TabView(selection: $homeViewModel.currentIndex) {
                ForEach(homeViewModel.photoList.indices, id: \.self) { index in
                    Image(uiImage: homeViewModel.photoList[index].image)
                        .resizable()
                        .scaledToFill()
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                } //: ForEach
            } //: TabView
            .frame(height: 250)
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            
            Text("\(homeViewModel.currentIndex + 1) / \(homeViewModel.checkTheCountOfPhotoList())")
                .font(.caption)
                .padding(5)
                .padding(.horizontal, 5)
                .foregroundStyle(.white)
                .background(
                    RoundedRectangle(cornerRadius: 25.0)
                        .foregroundStyle(.black.opacity(0.5))
                )
                .padding([.trailing, .bottom], 10)
        } //: ZStack
        .onReceive(homeViewModel.popularPhotoTimer) { _ in
            withAnimation {
                homeViewModel.currentIndex = (homeViewModel.currentIndex + 1) % homeViewModel.checkTheCountOfPhotoList()
            }
        }
    }
}

#Preview {
    HomeView()
        .applyBackgroundColor()
        .environment(\.backgroundColor, .customBlack0)
        .environmentObject(Path())
}
