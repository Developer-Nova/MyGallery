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
                
                Spacer()
            }
            .foregroundStyle(.gray)
            .padding(.horizontal)
            
            LazyVGrid(columns: searchResultsTabViewModel.photosColumns, spacing: 3) {
                ForEach(searchResultsTabViewModel.searchPhotoList, id: \.id) { photo in
                    ZStack(alignment: .bottomLeading) {
                        Rectangle()
                            .overlay {
                                AsyncImage(url: URL(string: photo.photoUrls.regular)) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .background(
                                            Color.gray
                                        )
                                        .onTapGesture {
                                            pathModel.paths.append(.photoDescriptionView(photoObject: photo, image: HashableImage(image: image)))
                                        }
                                } placeholder: {
                                    CustomProgressView()
                                }
                            }
                            .aspectRatio(0.7, contentMode: .fill)
                            .contentShape(Rectangle())
                            .clipped()
                        
                        Text(photo.user.name)
                            .font(.system(size: 13, weight: .bold))
                            .foregroundStyle(.white)
                            .padding([.bottom, .leading], 7)
                    } //: ZStack
                } //: ForEach
            } //: LazyVGrid
            
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
        } //: ScrollView
    }
}

#Preview {
    PhotoView(searchResultsTabViewModel: SearchResultsTabViewModel())
        .applyBackgroundColor()
        .environment(\.backgroundColor, .customBlack0)
        .environmentObject(Path())
}
