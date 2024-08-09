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
        if homeViewModel.isLoading && homeViewModel.isPhotoListEmpty() {
            CustomProgressView()
        } else {
            HomeContentView(homeViewModel: homeViewModel)
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
        VStack {
            TitleView()

            PhotoScrollView(homeViewModel: homeViewModel)
        } //: VStack
        .applyBackgroundColor()
        .onAppear {
            if homeViewModel.isInitialAppear {
                homeViewModel.getPopularPhotoList()
                homeViewModel.changeInitialAppear()
            } //: if Condition
        }
    }
}

// MARK: - TitleView
private struct TitleView: View {
    @EnvironmentObject private var pathModel: Path
    
    fileprivate init() { }
    
    fileprivate var body: some View {
        HStack {
            Text("My")
                .strikethrough()
            
            Text("Gallery")
        } //: HStack
        .font(.system(size: 20, weight: .bold))
        .foregroundStyle(Color.white)
        .padding(.vertical, 5)
    }
}

// MARK: - PhotoScrollView
private struct PhotoScrollView: View {
    @EnvironmentObject private var pathModel: Path
    @ObservedObject private var homeViewModel: HomeViewModel
    
    fileprivate init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: homeViewModel.photosColumns, spacing: 3) {
                ForEach(homeViewModel.photoList, id: \.id) { photo in
                    ZStack(alignment: .bottomLeading) {
                        Rectangle()
                            .overlay {
                                AsyncImage(url: URL(string: photo.photoUrls.regular)) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .onTapGesture {
                                            pathModel.paths.append(.photoDescriptionView(photoObject: photo, image: .init(image: image)))
                                        }
                                } placeholder: {
                                    CustomProgressView()
                                }
                            }
                            .aspectRatio(0.6, contentMode: .fill)
                            .contentShape(Rectangle())
                            .clipped()
                            
                        
                        Text(photo.user.name)
                            .font(.system(size: 15, weight: .bold))
                            .foregroundStyle(.white)
                            .padding([.bottom, .leading], 7)
                    } //: ZStack
                } //: ForEach
            } //: LazyVGrid
            
            Group {
                if homeViewModel.isLoading {
                    CustomProgressView()
                } else {
                    MoreButton(title: "More Photos") {
                        homeViewModel.morePhotoList()
                    }
                } //: if Condition
            } //: Group
            .padding(.top, 25)
            .padding(.bottom, 40)
        } //: ScrollView
    }
}

#Preview {
    HomeView()
        .environment(\.backgroundColor, .customBlack0)
        .environmentObject(Path())
}
