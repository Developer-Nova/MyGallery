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
        static let search = "/search/photos"
        static let topics = "/topics"
        static let totalStats = "/stats/total"
        static let monthStats = "/stats/month"
        
        static func photos(id: String = "") -> String {
            "/photos/\(id)"
        }
        
        static func topicsPhotos(id: String) -> String {
            "/topics/\(id)/photos"
        }
    }
}
