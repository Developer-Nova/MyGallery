//
//  UnsplashAPI.swift
//  MyGallery
//
//  Created by Nova on 6/2/24.
//

import Foundation

struct UnsplashAPI {
    static let baseURL = URL(string: "https://api.unsplash.com")
    private static var accessKey: String {
        guard let key = Bundle.main.infoDictionary?["UnsplashAPIKey"] as? String else {
            fatalError("APIKey is incorrect.")
        }
        
        return key
    }
    
    struct Endpoints {
        static let photos = "/photos + \(UnsplashAPI.accessKey)"
        static let random = "/photos/random + \(UnsplashAPI.accessKey)"
    }
}
