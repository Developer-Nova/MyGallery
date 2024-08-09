//
//  PhotoScrollView.swift
//  MyGallery
//
//  Created by Nova on 8/9/24.
//

import SwiftUI

struct PhotoScrollView<topContent: View, bottomContent: View>: View {
    @EnvironmentObject private var pathModel: Path
    @Binding private var photoList: [PhotoResponseDTO]
    
    private let columns: [GridItem]
    private let spacing: CGFloat
    private let topContent: topContent
    private let bottomContent: bottomContent
    
    init(
        photoList: Binding<[PhotoResponseDTO]>,
        columns: [GridItem],
        spacing: CGFloat,
        @ViewBuilder topContent: () -> topContent,
        @ViewBuilder bottomContent: () -> bottomContent
    ) {
        self._photoList = photoList
        self.columns = columns
        self.spacing = spacing
        self.topContent = topContent()
        self.bottomContent = bottomContent()
    }
    
    var body: some View {
        ScrollView(.vertical) {
            self.topContent
            
            LazyVGrid(columns: self.columns, spacing: self.spacing) {
                ForEach(self.photoList, id: \.id) { photo in
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
            
            self.bottomContent
        } //: ScrollView
    }
}

#Preview {
    PhotoScrollView(photoList: .constant([PhotoResponseDTO.toModel()]), columns: [.init()], spacing: 3) {
        EmptyView()
    } bottomContent: {
        EmptyView()
    }
    .applyBackgroundColor()
    .environment(\.backgroundColor, .customBlack0)
}
