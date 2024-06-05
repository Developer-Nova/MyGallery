//
//  UnsplashAPIEndpoints.swift
//  MyGallery
//
//  Created by Nova on 6/5/24.
//

import Foundation

struct UnsplashAPIEndpoints {
    // MARK: - Host
    private static let baseURL = UnsplashAPI.baseURL
    
    // MARK: - APIKey
    private static let accessKey = UnsplashAPI.accessKey
    
    // MARK: - Path
    private static let photos = UnsplashAPI.Path.photos
    private static let randoms = UnsplashAPI.Path.random
    
    private init() { }
    
    static func getNewPhotoList(query photoRequestDTO: PhotoRequestDTO? = nil) -> Endpoint<[PhotoResponseDTO]> {
        return Endpoint(
            baseURL: baseURL,
            path: photos,
            method: .get,
            queryParameters: photoRequestDTO,
            headers: accessKey
        )
    }
    
    static func getRandomPhotoList(query photoRequestDTO: PhotoRequestDTO? = nil) -> Endpoint<[PhotoResponseDTO]> {
        return Endpoint(
            baseURL: baseURL,
            path: randoms,
            method: .get,
            queryParameters: photoRequestDTO,
            headers: accessKey
        )
    }
}
