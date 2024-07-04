//
//  Photo.swift
//  MyGallery
//
//  Created by Nova on 6/18/24.
//

import SwiftUI

struct Photo: Hashable {
    let id: UUID = UUID()
    let image: UIImage
    
    init(image: UIImage) {
        self.image = image
    }
}
