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
            Picker("SearchInfo", selection: $searchResultsTabViewModel.selectedPicker) {
                ForEach(TabInfo.allCases, id: \.self) { tabInfo in
                    Text(tabInfo.rawValue)
                }
            } //: Picker
            .pickerStyle(.segmented)
            .padding()
            
            if searchResultsTabViewModel.isLoading && searchResultsTabViewModel.searchResult.results.isEmpty {
                CustomProgressView()
            } else {
                switch searchResultsTabViewModel.selectedPicker {
                case .photo:
                    PhotoView(searchResultsTabViewModel: searchResultsTabViewModel)
                case .user:
                    UserView()
                case .collection:
                    CollectionView()
                }
            } //: if Condition
        } //: VStack
        .applyBackgroundColor()
    }
}

#Preview {
    SearchResultsTabView(searchResultsTabViewModel: SearchResultsTabViewModel())
        .applyBackgroundColor()
        .environment(\.backgroundColor, .customBlack0)
}
