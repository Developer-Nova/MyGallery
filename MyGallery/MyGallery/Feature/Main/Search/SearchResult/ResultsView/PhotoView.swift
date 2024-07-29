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
        ScrollView(.vertical) {
            HStack {
                Text(searchResultsTabViewModel.total)
                
                Text(searchResultsTabViewModel.totalPage)
            }
            .foregroundStyle(.gray)
            
            LazyVGrid(columns: searchResultsTabViewModel.photosColumns, spacing: 3) {
                ForEach(searchResultsTabViewModel.photoList, id: \.id) { photo in
                    Rectangle()
                        .overlay {
                            Image(uiImage: photo.image)
                                .resizable()
                                .scaledToFill()
                        }
                        .background(
                            Color.gray
                        )
                        .aspectRatio(0.7, contentMode: .fill)
                        .clipped()
                        .contentShape(Rectangle())
                        .onTapGesture {
                            pathModel.paths.append(.photoDescriptionView(photo: photo))
                        }
                } //: ForEach
            } //: LazyVGrid
            
            Group {
                if searchResultsTabViewModel.isLoading {
                    CustomProgressView()
                } else {
                    MoreButtonView(title: "More Photos") {
                        searchResultsTabViewModel.morePhotoList()
                    }
                } //: if Condition
            } //: Group
            .padding(.top, 25)
            .padding(.bottom, 40)
        } //: ScrollView
    }
}

#Preview {
    PhotoView(searchResultsTabViewModel: SearchResultsTabViewModel())
        .applyBackgroundColor()
        .environment(\.backgroundColor, .customBlack0)
        .environmentObject(Path())
}
