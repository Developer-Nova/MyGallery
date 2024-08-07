//
//  SearchView.swift
//  MyGallery
//
//  Created by Nova on 6/8/24.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject private var pathModel: Path
    @EnvironmentObject private var searchViewModel:SearchViewModel
    @StateObject private var searchResultsTabViewModel = SearchResultsTabViewModel()
    
    var body: some View {
        VStack {
            SearchBarView(searchResultsTabViewModel: searchResultsTabViewModel)
            
            if searchViewModel.isLoading {
                CustomProgressView()
            } else {
                switch searchViewModel.selection {
                case .topicView:
                    TopicView()
                case .recentSearchView:
                    RecentSearchView()
                case .searchResultsView:
                    SearchResultsTabView(searchResultsTabViewModel: searchResultsTabViewModel)
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
    @EnvironmentObject private var searchViewModel: SearchViewModel
    @ObservedObject private var searchResultsTabViewModel: SearchResultsTabViewModel
    @FocusState private var textFieldIsFocused: Bool
    
    fileprivate init(
        searchResultsTabViewModel: SearchResultsTabViewModel
        
    ) {
        self.searchResultsTabViewModel = searchResultsTabViewModel
    }
    
    fileprivate var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(Color.customGray2)
                    .padding(.leading, 7)
                
                TextField(
                    "Search",
                    text: $searchResultsTabViewModel.searchText,
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
                .onChange(of: searchResultsTabViewModel.searchText) { _, newValue in
                    if newValue == "" {
                        searchResultsTabViewModel.clearSearchBarAndRemoveAllToPhotoList()
                    }
                }
                .onSubmit {
                    if !searchResultsTabViewModel.searchText.isEmpty {
                        self.textFieldIsFocused.toggle()
                        searchViewModel.addRecentSearchText(to: searchResultsTabViewModel.searchText)
                        searchViewModel.changeSelectionView(by: .searchResultsView)
                        searchResultsTabViewModel.removeAllToPhotoList()
                        searchResultsTabViewModel.getSearchPhotoList()
                    } //: if Condition
                }
                
                if !searchResultsTabViewModel.searchText.isEmpty {
                    Button(action: {
                        searchResultsTabViewModel.clearSearchBarAndRemoveAllToPhotoList()
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
                    searchResultsTabViewModel.clearSearchBarAndRemoveAllToPhotoList()
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

#Preview {
    SearchView()
        .environment(\.backgroundColor, .customBlack0)
        .environmentObject(Path())
        .environmentObject(SearchViewModel())
}
