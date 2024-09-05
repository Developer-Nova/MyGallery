//
//  SearchUserResponseDTO.swift
//  MyGallery
//
//  Created by Nova on 8/18/24.
//

// MARK: - SearchUserResponseDTO
struct SearchUserResponseDTO: ResponseDTO {
    let total: Int
    let totalPages: Int
    var results: [PhotoResponseDTO]
    
    private enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}

