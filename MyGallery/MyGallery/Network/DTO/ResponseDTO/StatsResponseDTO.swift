//
//  StatsResponseDTO.swift
//  MyGallery
//
//  Created by Nova on 7/8/24.
//

// MARK: - TotalStatsResponseDTO
struct TotalStatsResponseDTO: ResponseDTO {
    let totalPhotos: Int
    let photoDownloads: Int
    let photos: Int
    let downloads: Int
    let views: Int
    let photographers: Int
    let pixels: Int
    let downloadsPerSecond: Int
    let viewsPerSecond: Int
    let developers: Int
    let applications: Int
    let requests: Int

    enum CodingKeys: String, CodingKey {
        case totalPhotos = "total_photos"
        case photoDownloads = "photo_downloads"
        case photos
        case downloads
        case views
        case photographers
        case pixels
        case downloadsPerSecond = "downloads_per_second"
        case viewsPerSecond = "views_per_second"
        case developers
        case applications
        case requests
    }
}

// MARK: - MonthStatsResponseDTO
struct MonthStatsResponseDTO: ResponseDTO {
    let downloads: Int
    let views: Int
    let newPhotos: Int
    let newPhotographers: Int
    let newPixels: Int
    let newDevelopers: Int
    let newApplications: Int
    let newRequests: Int

    enum CodingKeys: String, CodingKey {
        case downloads
        case views
        case newPhotos = "new_photos"
        case newPhotographers = "new_photographers"
        case newPixels = "new_pixels"
        case newDevelopers = "new_developers"
        case newApplications = "new_applications"
        case newRequests = "new_requests"
    }
}
