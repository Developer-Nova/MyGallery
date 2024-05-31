//
//  PhotoElement.swift
//  MyGallery
//
//  Created by Nova on 5/31/24.
//

import Foundation

// MARK: - PhotoElement
struct PhotoElement: Codable {
    let id: String
    let slug: String
    let alternativeSlugs: AlternativeSlugs
    let createdAt: Date
    let width: Int
    let height: Int
    let color: String
    let blurHash: String
    let description: String?
    let altDescription: String
    let urls: Urls
    let links: Links
    let likes: Int
    let assetType: AssetType
    let user: User

    enum CodingKeys: String, CodingKey {
        case id
        case slug
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
        case assetType = "asset_type"
        case user
    }
}

// MARK: - AlternativeSlugs
struct AlternativeSlugs: Codable {
    let en, es, ja, fr: String
    let it, ko, de, pt: String
}

enum AssetType: String, Codable {
    case photo = "photo"
}

// MARK: - Urls
struct Urls: Codable {
    let raw, full, regular, small: String
    let thumb, smallS3: String

    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
}

// MARK: - WelcomeLinks
struct Links: Codable {
    let linksSelf: String
    let html: String
    let download: String
    let downloadLocation: String

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html
        case download
        case downloadLocation = "download_location"
    }
}

// MARK: - User
struct User: Codable {
    let id: String
    let updatedAt: Date
    let username, name, firstName, lastName: String
    let portfolioURL: String?
    let bio: String?
    let location: String
    let links: UserLinks
    let profileImage: ProfileImage
    let instagramUsername: String?
    let totalCollections, totalLikes, totalPhotos, totalPromotedPhotos: Int
    let totalIllustrations, totalPromotedIllustrations: Int
    let acceptedTos, forHire: Bool
    let social: Social

    enum CodingKeys: String, CodingKey {
        case id
        case updatedAt = "updated_at"
        case username, name
        case firstName = "first_name"
        case lastName = "last_name"
        case portfolioURL = "portfolio_url"
        case bio, location, links
        case profileImage = "profile_image"
        case instagramUsername = "instagram_username"
        case totalCollections = "total_collections"
        case totalLikes = "total_likes"
        case totalPhotos = "total_photos"
        case totalPromotedPhotos = "total_promoted_photos"
        case totalIllustrations = "total_illustrations"
        case totalPromotedIllustrations = "total_promoted_illustrations"
        case acceptedTos = "accepted_tos"
        case forHire = "for_hire"
        case social
    }
}

// MARK: - UserLinks
struct UserLinks: Codable {
    let linksSelf, html, photos, likes: String
    let portfolio, following, followers: String

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, photos, likes, portfolio, following, followers
    }
}

// MARK: - ProfileImage
struct ProfileImage: Codable {
    let small: String
    let medium: String
    let large: String
}

// MARK: - Social
struct Social: Codable {
    let instagramUsername: String?
    let portfolioURL: String?

    enum CodingKeys: String, CodingKey {
        case instagramUsername = "instagram_username"
        case portfolioURL = "portfolio_url"
    }
}
