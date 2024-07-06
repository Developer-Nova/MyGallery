//
//  NewPhotoListRequestDTO.swift
//  MyGallery
//
//  Created by Nova on 6/4/24.
//

struct NewPhotoListRequestDTO: RequestDTO {
    var page: Int
    var perPage: Int = 30
    var orderBy: OrderBy
    
    init(
        page: Int = 1,
        orderBy: OrderBy = .latest
    ) {
        self.page = page
        self.orderBy = orderBy
    }
    
    private enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case orderBy = "order_by"
    }
}

enum OrderBy: String, Encodable {
    case latest
    case oldest
    case popular
}
