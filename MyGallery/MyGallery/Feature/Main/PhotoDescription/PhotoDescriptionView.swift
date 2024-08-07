//
//  PhotoDescriptionView.swift
//  MyGallery
//
//  Created by Nova on 6/10/24.
//

import SwiftUI

struct PhotoDescriptionView: View {
    @EnvironmentObject private var pathModel: Path
    @StateObject private var photoDescriptionViewModel = PhotoDescriptionViewModel()
    private var photo: PhotoResponseDTO
    private var image: HashableImage
    
    init(photo: PhotoResponseDTO, image: HashableImage) {
        self.photo = photo
        self.image = image
    }
    
    var body: some View {
        VStack {
            CustomNavigationBar(title: photo.user.name, leftButtonAction:  {
                pathModel.paths.removeLast()
            }, rightButtonAction: {
                // Todo - 공유 기능
            })
            
            ScrollView {
                self.image.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .scaledToFit()
                    .clipped()
            } //: ScrollView
        } //: VStack
        .applyBackgroundColor()
    }
}

#Preview {
    PhotoDescriptionView(photo: .toModel(), image: HashableImage(image: Image(systemName: "star.fill")))
        .applyBackgroundColor()
        .environment(\.backgroundColor, .customBlack0)
}
