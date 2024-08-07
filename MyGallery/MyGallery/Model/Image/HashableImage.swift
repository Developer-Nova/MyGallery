//
//  HashableImage.swift
//  MyGallery
//
//  Created by Nova on 8/5/24.
//

import SwiftUI

struct HashableImage: Hashable {
    let image: Image
    private let id: UUID
    
    init(
        image: Image,
        id: UUID = UUID()
    ) {
        self.image = image
        self.id = id
    }
}

extension HashableImage {
    static func == (lhs: HashableImage, rhs: HashableImage) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
