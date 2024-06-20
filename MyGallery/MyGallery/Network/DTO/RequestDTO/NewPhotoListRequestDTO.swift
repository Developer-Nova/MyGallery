//
//  NewPhotoListRequestDTO.swift
//  MyGallery
//
//  Created by Nova on 6/4/24.
//

struct NewPhotoListRequestDTO: RequestDTO {
    let page: Int = 1
    var perPage: Int = 30
    var orderBy: OrderBy = .popular
    
    private enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case orderBy = "order_by"
    }
    
    enum OrderBy: String, Encodable {
        case latest
        case oldest
        case popular
    }
}
