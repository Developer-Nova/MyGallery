//
//  SearchView.swift
//  MyGallery
//
//  Created by Nova on 6/8/24.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject private var pathModel: Path
    @StateObject private var searchViewModel = SearchViewModel()
    
    var body: some View {
        VStack {
            SearchBarView(searchViewModel: searchViewModel)
            
            if searchViewModel.isLoading {
                CustomProgressView()
            } else {
                switch searchViewModel.selection {
                case .topicView:
                    TopicView(searchViewModel: searchViewModel)
                case .recentSearchView:
                    RecentSearchView(searchViewModel: searchViewModel)
                case .searchResultsView:
                    SearchResultsView()
                }
            } //: if Condition
        } //: VStack
        .applyBackgroundColor()
        .onAppear {
            if searchViewModel.isInitialAppear {
                searchViewModel.changeInitialAppear()
                searchViewModel.getTopicList()
            } //: if Condition
        }
    }
}

// MARK: - SearchBarView
private struct SearchBarView: View {
    @EnvironmentObject private var pathModel: Path
    @ObservedObject private var searchViewModel: SearchViewModel
    @FocusState private var textFieldIsFocused: Bool
    
    fileprivate init(searchViewModel: SearchViewModel) {
        self.searchViewModel = searchViewModel
    }
    
    fileprivate var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(Color.customGray2)
                    .padding(.leading, 7)
                
                TextField(
                    "Search",
                    text: $searchViewModel.searchText,
                    prompt: Text("Search for English")
                                .foregroundStyle(Color.customGray2)
                )
                .foregroundStyle(Color.customGray2)
                .submitLabel(.search)
                .autocorrectionDisabled()
                .keyboardType(.alphabet)
                .focused($textFieldIsFocused)
                .onChange(of: self.textFieldIsFocused) { _, newValue in
                    withAnimation {
                        searchViewModel.changeIsFocused()
                    }
                    
                    if newValue == true {
                        searchViewModel.changeSelectionView(by: .recentSearchView)
                    } //: if Condition
                }
                .onSubmit {
                    if !searchViewModel.searchText.isEmpty {
                        searchViewModel.removeAllToPhotoList()
                        self.textFieldIsFocused.toggle()
                        searchViewModel.changeSelectionView(by: .searchResultsView)
                        searchViewModel.addRecentSearchText(to: searchViewModel.searchText)
                    }
                }
            
                if !searchViewModel.searchText.isEmpty {
                    Button(action: {
                        searchViewModel.clearSearchBarAndLoadImages()
                        self.textFieldIsFocused = true
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(Color.customGray2)
                    }) //: Button
                } //: if Condition
            } //: HStack
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .foregroundStyle(Color.customGray1)
            )
            
            if searchViewModel.isFocused {
                Button(action: {
                    self.textFieldIsFocused.toggle()
                    searchViewModel.clearSearchBarAndLoadImages()
                    searchViewModel.changeSelectionView(by: .topicView)
                }, label: {
                    Text("Cancel")
                        .foregroundStyle(.white)
                }) //: Button
                .padding([.vertical, .leading], 10)
            } //: if Condition
        } //: HStack
        .padding(.top, 10)
        .padding([.bottom, .horizontal])
    }
}

// MARK: - TopicView
private struct TopicView: View {
    @ObservedObject private var searchViewModel: SearchViewModel
    
    fileprivate init(searchViewModel: SearchViewModel) {
        self.searchViewModel = searchViewModel
    }
    
    fileprivate var body: some View {
        ScrollView(showsIndicators: false) {
            HStack {
                Text("Topics")
                    .font(.system(size: 25, weight: .bold))
                    .foregroundStyle(.white)
                
                Spacer()
            } //: HStack
            .padding(.horizontal)
            
            LazyVGrid(columns: searchViewModel.columns, spacing: 10) {
                ForEach(searchViewModel.topicList, id: \.id) { topic in
                    Button(action: {
                        // Todo - topic 관련 사진 보여주기
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .overlay {
                                    // Todo - coverphoto 이미지
                                }
                                .foregroundStyle(.red)
                            
                            Text(topic.title)
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundStyle(.white)
                        } //: ZStack
                        .frame(width: 180, height: 150)
                    }) //: Button
                } //: ForEach
            } //: LazyVGrid
            
            Group {
                if searchViewModel.isLoading {
                    CustomProgressView()
                } else {
                    MoreButtonView(title: "More Topics") {
                        // Todo - topic 추가 네트워킹
                    }
                } //: if Condition
            } //: Group
            .padding(.top, 25)
            .padding(.bottom, 40)
        } //: ScrollView
        .frame(maxWidth: 370)
    }
}

#Preview {
    SearchView()
        .environment(\.backgroundColor, .customBlack0)
        .environmentObject(Path())
}
