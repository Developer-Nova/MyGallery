//
//  TopicResponseDTO.swift
//  MyGallery
//
//  Created by Nova on 7/7/24.
//

import Foundation

// MARK: - TopicElement
struct TopicResponseDTO: ResponseDTO {
    let id: String
    let slug: String
    let title: String
    let description: String
    let totalPhotos: Int
    let links: TopicLinks
    let status: String
    let coverPhoto: CoverPhoto
    let previewPhotos: [PreviewPhoto]

    enum CodingKeys: String, CodingKey {
        case id
        case slug
        case title
        case description
        case totalPhotos = "total_photos"
        case links, status
        case coverPhoto = "cover_photo"
        case previewPhotos = "preview_photos"
    }
}

// MARK: - CoverPhoto
struct CoverPhoto: Decodable {
    let id: String
    let slug: String
    let alternativeSlugs: AlternativeSlugs
    let createdAt: String
    let width: Int
    let height: Int
    let color: String?
    let blurHash: String?
    let description: String?
    let altDescription: String?
    let urls: Urls
    let links: CoverPhotoLinks
    let likes: Int
    let likedByUser: Bool
    let assetType: AssetType

    enum CodingKeys: String, CodingKey {
        case id, slug
        case alternativeSlugs = "alternative_slugs"
        case createdAt = "created_at"
        case width
        case height
        case color
        case blurHash = "blur_hash"
        case description
        case altDescription = "alt_description"
        case urls
        case links
        case likes
        case likedByUser = "liked_by_user"
        case assetType = "asset_type"
    }
}

// MARK: - AlternativeSlugs
struct AlternativeSlugs: Decodable {
    let ko: String
}

enum AssetType: String, Decodable {
    case photo = "photo"
}

// MARK: - CoverPhotoLinks
struct CoverPhotoLinks: Decodable {
    let download: String
    let downloadLocation: String

    enum CodingKeys: String, CodingKey {
        case download
        case downloadLocation = "download_location"
    }
}

// MARK: - Urls
struct Urls: Decodable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
    let smallS3: String

    enum CodingKeys: String, CodingKey {
        case raw
        case full
        case regular
        case small
        case thumb
        case smallS3 = "small_s3"
    }
}

// MARK: - TopicLinks
struct TopicLinks: Decodable {
    let photos: String

    enum CodingKeys: String, CodingKey {
        case photos
    }
}

// MARK: - PreviewPhoto
struct PreviewPhoto: Decodable {
    let id: String
    let slug: String
    let createdAt: String
    let updatedAt: String
    let blurHash: String?
    let assetType: AssetType
    let urls: Urls

    enum CodingKeys: String, CodingKey {
        case id
        case slug
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case blurHash = "blur_hash"
        case assetType = "asset_type"
        case urls
    }
}
