//
//  PhotoView.swift
//  MyGallery
//
//  Created by Nova on 7/14/24.
//

import SwiftUI

struct PhotoView: View {
    @EnvironmentObject private var pathModel: Path
    @ObservedObject private var searchResultsTabViewModel: SearchResultsTabViewModel
    
    init(searchResultsTabViewModel: SearchResultsTabViewModel) {
        self.searchResultsTabViewModel = searchResultsTabViewModel
    }
    
    var body: some View {
        PhotoScrollView(photoList: self.$searchResultsTabViewModel.searchPhotoList, columns: self.searchResultsTabViewModel.photosColumns, spacing: 3) {
            HStack {
                Text(searchResultsTabViewModel.total)
                
                Text(searchResultsTabViewModel.totalPage)
                
                Spacer()
            }
            .foregroundStyle(.gray)
            .padding(.horizontal)
        } bottomContent: {
            Group {
                if searchResultsTabViewModel.isLoading {
                    CustomProgressView()
                } else {
                    MoreButton(title: "More Photos") {
                        searchResultsTabViewModel.morePhotoList()
                    }
                } //: if Condition
            } //: Group
            .padding(.top, 25)
            .padding(.bottom, 40)
        } //: PhotoScrollView
    }
}

#Preview {
    PhotoView(searchResultsTabViewModel: SearchResultsTabViewModel())
        .applyBackgroundColor()
        .environment(\.backgroundColor, .customBlack0)
        .environmentObject(Path())
}
