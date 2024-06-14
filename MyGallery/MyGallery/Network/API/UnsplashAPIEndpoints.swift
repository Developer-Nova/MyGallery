//
//  UnsplashAPIEndpoints.swift
//  MyGallery
//
//  Created by Nova on 6/5/24.
//

enum UnsplashAPIEndpoints {
    // MARK: - Host
    private static let baseURL = UnsplashAPI.baseURL
    
    // MARK: - APIKey
    private static let accessKey = UnsplashAPI.accessKey
    
    static func getPhotoListEndpoint(query photoRequestDTO: PhotoRequestDTO, path: String) -> Endpoint<[PhotoResponseDTO]> {
        return Endpoint(
            baseURL: baseURL,
            path: path,
            method: .get,
            queryParameters: photoRequestDTO,
            headers: accessKey
        )
    }
}
