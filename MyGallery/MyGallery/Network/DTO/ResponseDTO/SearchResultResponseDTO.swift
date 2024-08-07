//
//  SearchResultResponseDTO.swift
//  MyGallery
//
//  Created by Nova on 6/18/24.
//

// MARK: - SearchResultResponseDTO
struct SearchResultResponseDTO: ResponseDTO {
    let total: Int
    let totalPages: Int
    var results: [PhotoResponseDTO]
    
    private enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}
//    // MARK: - Result
//    struct Result: ResponseDTO {
//        let id: String
//        let alternativeSlugs: AlternativeSlugs
//        let createdAt: String
//        let width: Int
//        let height: Int
//        let color: String
//        let blurHash: String?
//        let description: String?
//        let altDescription: String
//        let urls: Urls
//        let links: Links
//        let likes: Int
//        let likedByUser: Bool
//        let assetType: AssetType
//        let user: User
//        
//        private enum CodingKeys: String, CodingKey {
//            case id
//            case alternativeSlugs = "alternative_slugs"
//            case createdAt = "created_at"
//            case width
//            case height
//            case color
//            case blurHash = "blur_hash"
//            case description
//            case altDescription = "alt_description"
//            case urls
//            case links
//            case likes
//            case likedByUser = "liked_by_user"
//            case assetType = "asset_type"
//            case user
//        }
//    }
//    
//    // MARK: - AlternativeSlugs
//    struct AlternativeSlugs: ResponseDTO {
//        let ko: String
//    }
//    
//    enum AssetType: String, ResponseDTO {
//        case photo = "photo"
//    }
//    
//    // MARK: - Links
//    struct Links: ResponseDTO {
//        let downloadLocation: String
//        
//        private enum CodingKeys: String, CodingKey {
//            case downloadLocation = "download_location"
//        }
//    }
//    
//    // MARK: - Urls
//    struct Urls: ResponseDTO {
//        let raw: String
//        let full: String
//        let regular: String
//        let small: String
//        let thumb: String
//        let smallS3: String
//        
//        private enum CodingKeys: String, CodingKey {
//            case raw
//            case full
//            case regular
//            case small
//            case thumb
//            case smallS3 = "small_s3"
//        }
//    }
//    
//    // MARK: - User
//    struct User: ResponseDTO {
//        let id: String
//        let username: String
//        let name: String
//        let portfolioURL: String?
//        let bio: String?
//        let links: UserLinks
//        let profileImage: ProfileImage
//        let totalPhotos: Int
//        let totalIllustrations: Int
//        let social: Social
//        
//        private enum CodingKeys: String, CodingKey {
//            case id
//            case username
//            case name
//            case portfolioURL = "portfolio_url"
//            case bio
//            case links
//            case profileImage = "profile_image"
//            case totalPhotos = "total_photos"
//            case totalIllustrations = "total_illustrations"
//            case social
//        }
//    }
//    
//    // MARK: - UserLinks
//    struct UserLinks: ResponseDTO {
//        let linksSelf: String
//        let html: String
//        let photos: String
//        let likes: String
//        let portfolio: String
//        let following: String
//        let followers: String
//        
//        private enum CodingKeys: String, CodingKey {
//            case linksSelf = "self"
//            case html
//            case photos
//            case likes
//            case portfolio
//            case following
//            case followers
//        }
//    }
//    
//    // MARK: - ProfileImage
//    struct ProfileImage: ResponseDTO {
//        let small: String
//        let medium: String
//        let large: String
//    }
//    
//    // MARK: - Social
//    struct Social: ResponseDTO {
//        let instagramUsername: String?
//        let portfolioURL: String?
//        let twitterUsername: String?
//        
//        private enum CodingKeys: String, CodingKey {
//            case instagramUsername = "instagram_username"
//            case portfolioURL = "portfolio_url"
//            case twitterUsername = "twitter_username"
//        }
//    }
//}

extension SearchResultResponseDTO {
    static func toModel() -> SearchResultResponseDTO {
        .init(total: 0,
              totalPages: 0,
              results: [PhotoResponseDTO(id: "",
                               alternativeSlugs: AlternativeSlug(ko: ""),
                               createdAt: "",
                               width: 0,
                               height: 0,
                               color: "",
                               blurHash: "",
                               description: "",
                               altDescription: "",
                               photoUrls: PhotoUrls(raw: "", full: "", regular: "", small: "", thumb: "", smallS3: ""),
                               links: Links(downloadLocation: ""),
                               likes: 0,
                               assetType: .photo,
                               user: User(id: "",
                                          username: "",
                                          name: "",
                                          portfolioURL: "",
                                          bio: "",
                                          links: UserLinks(linksSelf: "",
                                                           html: "",
                                                           photos: "",
                                                           likes: "",
                                                           portfolio: "",
                                                           following: "",
                                                           followers: ""),
                                          profileImage: ProfileImage(small: "", medium: "", large: ""),
                                          totalPhotos: 0,
                                          totalIllustrations: 0,
                                          social: Social(instagramUsername:"", twitterUsername: ""))
                              )
              ])
    }
}
