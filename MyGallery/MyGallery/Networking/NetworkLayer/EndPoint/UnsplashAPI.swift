//
//  UnsplashAPI.swift
//  MyGallery
//
//  Created by Nova on 6/2/24.
//

import Foundation

struct UnsplashAPI {
    static let baseURL = "https://api.unsplash.com"
    
    struct Endpoints {
        static let photos = "/photos"
        static let random = "/photos/random"
    }
}
