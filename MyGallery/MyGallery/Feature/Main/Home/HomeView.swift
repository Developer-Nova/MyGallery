//
//  HomeView.swift
//  MyGallery
//
//  Created by Nova on 7/4/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var homeViewModel = HomeViewModel()
    
    var body: some View {
        VStack {
            Text("Home View")
// MARK: - HomeContentView
private struct HomeContentView: View {
    @ObservedObject private var homeViewModel: HomeViewModel
    
    fileprivate init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
    }
    
    fileprivate var body: some View {
        ScrollView {
            TitleView()
                .padding(.bottom)

            PopularPhotoContentVeiw(homeViewModel: homeViewModel)
            
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
            .font(.title)
            .fontWeight(.bold)
            .foregroundStyle(Color.white)
            .padding(.horizontal)
            
            Rectangle()
                .frame(height: 2)
                .foregroundStyle(Color.gray.opacity(0.2))
        } //: VStack
        .padding(.top, 10)
    }
}

// MARK: - PopularPhotoContentView
private struct PopularPhotoContentVeiw: View {
    @ObservedObject private var homeViewModel: HomeViewModel
    
    fileprivate init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("인기 사진")
                .foregroundStyle(Color.white)
                .font(.system(size: 20, weight: .bold))
                .padding(.leading)
            
            ZStack(alignment: .bottomTrailing) {
                TabView(selection: $homeViewModel.currentIndex) {
                    ForEach(0..<homeViewModel.photoList.count, id: \.self) { index in
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
        } //: VStack
    }
}

#Preview {
    HomeView()
        .applyBackgroundColor()
        .environment(\.backgroundColor, .customBlack0)
}
