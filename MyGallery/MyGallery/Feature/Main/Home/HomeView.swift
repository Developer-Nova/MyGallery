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
    @EnvironmentObject private var pathModel: Path
    @ObservedObject private var homeViewModel: HomeViewModel
    
    fileprivate init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            ZStack(alignment: .bottomTrailing) {
                TabView(selection: $homeViewModel.currentIndex) {
                    ForEach(homeViewModel.photoList.indices, id: \.self) { index in
                        Image(uiImage: homeViewModel.photoList[index].image)
                            .resizable()
                            .scaledToFill()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                            .onTapGesture {
                                pathModel.paths.append(.photoDescriptionView(photo: homeViewModel.photoList[index]))
                            }
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
            
            Text("Popular")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(7)
                .foregroundStyle(.white)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundStyle(.black.opacity(0.5))
                )
                .padding([.top, .leading], 5)
        } //: ZStack
    }
}

// MARK: - TopicButtonView
private struct TopicButtonView: View {
    @ObservedObject private var homeViewModel: HomeViewModel
    
    fileprivate init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
    }
    
    fileprivate var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Topics")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(7)
                    .foregroundStyle(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(.black.opacity(0.5))
                    )
                    .padding([.top, .leading], 5)
                
                Spacer()
                
                Button(action: {
                    // Todo - 전체 topic view 띄워주기
                }, label: {
                    HStack {
                        Text("더보기")
                            .font(.system(size: 15))
                        
                        Image("moreTopics")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18)
                    } //: HStack
                    .foregroundStyle(.gray)
                })
                .padding(.trailing, 7)
            } //: HStack
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: homeViewModel.columns, spacing: 10) {
                    ForEach(homeViewModel.topicList, id: \.id) { topic in
                        Button(action: {
                            // Todo - 해당 topic 으로 검색
                        }, label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 25.0)
                                    .frame(height: 40)
                                    .foregroundStyle(.customPurple0)
                                
                                Text("\(topic.title)")
                                    .font(.system(size: 17))
                                    .padding()
                                    .foregroundStyle(.white)
                            } //: ZStack
                        }) //: Button
                    } //: ForEach
                } //: LazyHGrid
                .padding(.horizontal, 5)
            } //: ScrollView
            .padding([.horizontal, .bottom], 5)
        } //: VStack
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.purple.opacity(0.3))
        )
        .padding(5)
    }
}

#Preview {
    HomeView()
        .applyBackgroundColor()
        .environment(\.backgroundColor, .customBlack0)
        .environmentObject(Path())
}
