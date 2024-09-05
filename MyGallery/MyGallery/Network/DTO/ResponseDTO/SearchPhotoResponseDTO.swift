//
//  SearchPhotoResponseDTO.swift
//  MyGallery
//
//  Created by Nova on 6/18/24.
//

// MARK: - SearchResultResponseDTO
struct SearchPhotoResponseDTO: ResponseDTO {
    let total: Int
    let totalPages: Int
    var results: [PhotoResponseDTO]
    
    private enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}

extension SearchPhotoResponseDTO {
    static func toModel() -> SearchPhotoResponseDTO {
        .init(total: 0,
              totalPages: 0,
              results: [PhotoResponseDTO.toModel()]
        )
    }
}
