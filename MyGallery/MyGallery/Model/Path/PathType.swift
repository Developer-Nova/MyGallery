//
//  PathType.swift
//  MyGallery
//
//  Created by Nova on 6/8/24.
//

import SwiftUI

enum PathType: Hashable {
    case photoDescriptionView(photoObject: PhotoResponseDTO, image: HashableImage)
    case searchPhotoView
    case topicPhotoScrollView(topicTitle: String)
}
