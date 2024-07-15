//
//  PhotoView.swift
//  MyGallery
//
//  Created by Nova on 7/14/24.
//

import SwiftUI

struct PhotoView: View {
    @EnvironmentObject private var pathModel: Path
    @ObservedObject private var searchViewModel: SearchViewModel
    
    init(searchViewModel: SearchViewModel) {
        self.searchViewModel = searchViewModel
    }
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: searchViewModel.columns, spacing: 3) {
                ForEach(searchViewModel.photoList, id: \.id) { photo in
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
                if searchViewModel.isLoading {
                    CustomProgressView()
                } else {
                    Button(action: {
                        searchViewModel.morePhotoList(of: searchViewModel.selection)
                    }, label: {
                        Image("synchronization")
                    })
                } //: if Condition
            } //: Group
            .padding(.top, 30)
            
            Spacer()
        } //: ScrollView
    }
}

#Preview {
    PhotoView(searchViewModel: SearchViewModel())
        .applyBackgroundColor()
        .environment(\.backgroundColor, .customBlack0)
        .environmentObject(Path())
}
