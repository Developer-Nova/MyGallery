//
//  TopicPhotoView.swift
//  MyGallery
//
//  Created by Nova on 7/31/24.
//

import SwiftUI

struct TopicPhotoView: View {
    @EnvironmentObject private var pathModel: Path
    @EnvironmentObject private var searchViewModel: SearchViewModel
    private var topicTitle: String
    
    init(
        topicTitle: String
    ) {
        self.topicTitle = topicTitle
    }
    
    var body: some View {
        VStack {
            CustomNavigationBar(title: self.topicTitle, isDisplayRightButton: false, leftButtonAction: {
                pathModel.paths.removeLast()
                searchViewModel.removeAllToPhotoList()
            })
            
            ScrollView(.vertical) {
                LazyVGrid(columns: searchViewModel.topicsPhotosColumns, spacing: 3) {
                    ForEach(searchViewModel.photoList, id: \.id) { photo in
                        Rectangle()
                            .overlay {
                                AsyncImage(url: URL(string: photo.photoUrls.regular)) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .background(
                                            Color.gray
                                        )
                                        .contentShape(Rectangle())
                                        .onTapGesture {
                                            pathModel.paths.append(.photoDescriptionView(photoObject: photo, image: .init(image: image)))
                                        }
                                } placeholder: {
                                    CustomProgressView()
                                } //: AsyncImage
                            }
                            .aspectRatio(0.7, contentMode: .fill)
                            .clipped()
                    } //: ForEach
                } //: LazyVGrid
                
                Group {
                    if searchViewModel.isLoading {
                        CustomProgressView()
                    } else {
                        MoreButton(title: "More Photos") {
                            searchViewModel.morePhotoList()
                        }
                    } //: if Condition
                } //: Group
                .padding(.top, 25)
                .padding(.bottom, 40)
            } //: ScrollView
        } //: VStack
        .applyBackgroundColor()
    }
}

#Preview {
    TopicPhotoView(topicTitle: "Title")
        .applyBackgroundColor()
        .environment(\.backgroundColor, .customBlack0)
        .environmentObject(Path())
        .environmentObject(SearchViewModel())
}
