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
        UISegmentedControl.appearance().backgroundColor = .customGray1
        UISegmentedControl.appearance().selectedSegmentTintColor = .darkGray
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.customGray2], for: .normal)
    }
    
    var body: some View {
        VStack {
            Picker("SearchInfo", selection: $searchResultsTabViewModel.selectedPicker) {
                ForEach(TabInfo.allCases, id: \.self) { tabInfo in
                    Text(tabInfo.rawValue)
                }
            } //: Picker
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
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
