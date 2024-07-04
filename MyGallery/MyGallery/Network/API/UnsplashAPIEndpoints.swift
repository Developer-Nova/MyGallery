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
    
    static func getPhotoListEndpoint<T>(query photoRequestDTO: RequestDTO, path: String, type: T.Type) -> Endpoint<T> {
        return Endpoint(
            baseURL: baseURL,
            path: path,
            method: .get,
            queryParameters: photoRequestDTO,
            headers: accessKey
        )
    }
}
