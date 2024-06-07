//
//  UnsplashAPI.swift
//  MyGallery
//
//  Created by Nova on 6/2/24.
//

import Foundation

enum UnsplashAPI {
    static let baseURL = "https://api.unsplash.com"
    static var accessKey: [String: String] {
        guard let key = Bundle.main.infoDictionary?["UnsplashAPIKey"] as? String else {
            fatalError("APIKey is incorrect.")
        }
        return ["Authorization": "Client-ID \(key)"]
    }
    
    enum Path {
        static let photos = "/photos"
        static let random = "/photos/random"
    }
}
