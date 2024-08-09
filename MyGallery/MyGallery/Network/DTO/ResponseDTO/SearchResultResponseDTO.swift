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
