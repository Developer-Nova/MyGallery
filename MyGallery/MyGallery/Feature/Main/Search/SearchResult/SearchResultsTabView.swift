//
//  SearchResultsTabView.swift
//  MyGallery
//
//  Created by Nova on 7/14/24.
//

import SwiftUI

struct SearchResultsTabView: View {
    @ObservedObject private var searchResultsTabViewModel: SearchResultsTabViewModel
    
    init(searchResultsTabViewModel: SearchResultsTabViewModel) {
        self.searchResultsTabViewModel = searchResultsTabViewModel
    }
    
    var body: some View {
        VStack {
            // Todo - 상단 탭뷰 Photo, Collection, User
            
            if searchResultsTabViewModel.isLoading && searchResultsTabViewModel.photoList.isEmpty {
                CustomProgressView()
            } else {
                PhotoView(searchResultsTabViewModel: searchResultsTabViewModel)
            } //: if Condition
        } //: VStack
        .applyBackgroundColor()
    }
}

#Preview {
    SearchResultsTabView(searchResultsTabViewModel: SearchResultsTabViewModel())
        .environment(\.backgroundColor, .customBlack0)
}
