//
//  UnsplashNetworkProvider.swift
//  MyGallery
//
//  Created by Nova on 6/13/24.
//

import Foundation

final class UnsplashNetworkProvider: Providable {
    static let shared = UnsplashNetworkProvider()
    var session: URLSession = .shared
    
    private init() { }
    
    func getNewPhotoList() -> [PhotoResponseDTO] {
        let endpoint = UnsplashAPIEndpoints.getPhotoListEndpoint(path: UnsplashAPI.Path.photos)
        var photoList = [PhotoResponseDTO]()
        
        request(endpoint: endpoint) { result in
            switch result {
            case .success(let data):
                photoList = data
            case .failure(let error):
                print(error)
            }
        }
        
        return photoList
    }
}
