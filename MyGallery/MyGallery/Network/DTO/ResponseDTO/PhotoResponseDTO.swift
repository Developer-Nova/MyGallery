//
//  PhotoResponseDTO.swift
//  MyGallery
//
//  Created by Nova on 5/31/24.
//

// MARK: - PhotoResponseDTO
struct PhotoResponseDTO: ResponseDTO {
    let id: String
    let alternativeSlugs: AlternativeSlug
    let createdAt: String
    let width: Int
    let height: Int
    let color: String
    let blurHash: String?
    let description: String?
    let altDescription: String?
    let urls: Urls
    let links: Links
    let likes: Int
    let assetType: AssetType
    let user: User
    
    enum AssetType: String, ResponseDTO {
        case photo = "photo"
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
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
    
    
    // MARK: - AlternativeSlug
    struct AlternativeSlug: ResponseDTO {
        let ko: String
    }
    
    // MARK: - Urls
    struct Urls: ResponseDTO {
        let raw: String
        let full: String
        let regular: String
        let small: String
        let thumb: String
        let smallS3: String
        
        private enum CodingKeys: String, CodingKey {
            case raw
            case full
            case regular
            case small
            case thumb
            case smallS3 = "small_s3"
        }
    }
    
    // MARK: - Links
    struct Links: ResponseDTO {
        let downloadLocation: String
        
        private enum CodingKeys: String, CodingKey {
            case downloadLocation = "download_location"
        }
    }
    
    // MARK: - User
    struct User: ResponseDTO {
        let id: String
        let username: String
        let name: String
        let portfolioURL: String?
        let bio: String?
        let links: UserLinks
        let profileImage: ProfileImage
        let totalPhotos: Int
        let totalIllustrations: Int
        let social: Social
        
        private enum CodingKeys: String, CodingKey {
            case id
            case username
            case name
            case portfolioURL = "portfolio_url"
            case bio
            case links
            case profileImage = "profile_image"
            case totalPhotos = "total_photos"
            case totalIllustrations = "total_illustrations"
            case social
        }
    }
    
    // MARK: - UserLinks
    struct UserLinks: ResponseDTO {
        let linksSelf: String
        let html: String
        let photos: String
        let likes: String
        let portfolio: String
        let following: String
        let followers: String
        
        private enum CodingKeys: String, CodingKey {
            case linksSelf = "self"
            case html
            case photos
            case likes
            case portfolio
            case following
            case followers
        }
    }
    
    // MARK: - ProfileImage
    struct ProfileImage: ResponseDTO {
        let small: String
        let medium: String
        let large: String
    }
    
    // MARK: - Social
    struct Social: ResponseDTO {
        let instagramUsername: String?
        let twitterUsername: String?
        
        private enum CodingKeys: String, CodingKey {
            case instagramUsername = "instagram_username"
            case twitterUsername = "twitter_username"
        }
    }
}
