//
//  TopicPhotoView.swift
//  MyGallery
//
//  Created by Nova on 7/31/24.
//

import SwiftUI

struct TopicPhotoScrollView: View {
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
            }) //: CustomNavigationBar
            
            PhotoScrollView(photoList: self.$searchViewModel.photoList, columns: self.searchViewModel.topicsPhotosColumns, spacing: 3) {
                EmptyView()
            } bottomContent: {
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
            } //: PhotoScrollView
        } //: VStack
        .applyBackgroundColor()
    }
}

#Preview {
    TopicPhotoScrollView(topicTitle: "Title")
        .applyBackgroundColor()
        .environment(\.backgroundColor, .customBlack0)
        .environmentObject(Path())
        .environmentObject(SearchViewModel())
}
