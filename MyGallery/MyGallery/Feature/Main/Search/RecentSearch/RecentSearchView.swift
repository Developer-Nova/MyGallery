//
//  RecentSearchView.swift
//  MyGallery
//
//  Created by Nova on 7/14/24.
//

import SwiftUI

struct RecentSearchView: View {
    @ObservedObject private var searchViewModel: SearchViewModel
    
    init(searchViewModel: SearchViewModel) {
        self.searchViewModel = searchViewModel
    }
    
    var body: some View {
        ScrollView {
            HStack {
                Text("최근 검색어")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.white)
                
                Spacer()
                
                if !searchViewModel.recentSearchText.isEmpty {
                    Button(action: {
                        searchViewModel.changeIsDeleteRecentSearchText()
                    }, label: {
                        Text("Delete")
                            .font(.system(size: 15))
                            .foregroundStyle(.white)
                    }) //: Button
                } //: if Condition
            } //: HStack
            .padding()
            .confirmationDialog("", isPresented: $searchViewModel.isDeleteRecentSearchText) {
                Button("Delete all", role: .destructive) {
                    searchViewModel.removeAllToRecentSearchText()
                } //: Button
            } message: {
                Text("Do you want to delete all recent searches?")
            }
            
            ForEach(searchViewModel.recentSearchText, id: \.self) { searchText in
                RecentSearchCellView(searchText: searchText)
            } //: ForEach
        } //: ScrollView
    }
}

// MARK: - RecentSearchCellView
private struct RecentSearchCellView: View {
    private var searchText: String
    
    fileprivate init(searchText: String) {
        self.searchText = searchText
    }
    
    fileprivate var body: some View {
        VStack {
            Button(action: {
                
            }, label: {
                HStack {
                    Image("search")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 25, height: 25)
                    
                    Text(self.searchText)
                        .font(.system(size: 17))
                        .foregroundStyle(.white)
                    
                    Spacer()
                } //: HStack
                .padding(.horizontal)
            }) //: Button
            
            Divider()
                .background(.gray)
                .padding(.horizontal)
        } //: VStack
        .padding(.bottom, 5)
    }
}

#Preview {
    RecentSearchView(searchViewModel: SearchViewModel())
        .applyBackgroundColor()
        .environment(\.backgroundColor, .customBlack0)
}

#Preview("CellView") {
    RecentSearchCellView(searchText: "검색어")
        .applyBackgroundColor()
        .environment(\.backgroundColor, .customBlack0)
}
