//
//  PhotoDescriptionView.swift
//  MyGallery
//
//  Created by Nova on 6/10/24.
//

import SwiftUI

struct PhotoDescriptionView: View {
    private var photo: Photo
    
    init(photo: Photo) {
        self.photo = photo
    }
    
    var body: some View {
        Image(uiImage: photo.image)
    }
}

#Preview {
    PhotoDescriptionView(photo: .init(image: UIImage(systemName: "star.fill")!))
}
