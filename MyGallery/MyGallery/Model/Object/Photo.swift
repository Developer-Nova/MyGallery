//
//  Photo.swift
//  MyGallery
//
//  Created by Nova on 6/18/24.
//

import SwiftUI

struct Photo: Item {
    let id: UUID
    var image: UIImage
    
    init(
        id: UUID = UUID(),
        image: UIImage
    ) {
        self.id = id
        self.image = image
    }
}
