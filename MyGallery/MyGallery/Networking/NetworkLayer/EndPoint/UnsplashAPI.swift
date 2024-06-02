//
//  UnsplashAPI.swift
//  MyGallery
//
//  Created by Nova on 6/2/24.
//

import Foundation

struct UnsplashAPI {
    static let baseURL = URL(string: "https://api.unsplash.com")
    
    struct Endpoints {
        static let photos = "/photos"
    }
}
