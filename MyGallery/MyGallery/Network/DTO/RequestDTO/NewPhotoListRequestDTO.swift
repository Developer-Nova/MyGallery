//
//  NewPhotoListRequestDTO.swift
//  MyGallery
//
//  Created by Nova on 6/4/24.
//

struct NewPhotoListRequestDTO: RequestDTO {
    var page: Int? = 1
    var perPage: Int = 30
    var orderBy: OrderBy = .latest
    
    init(page: Int? = nil) {
        self.page = page
    }
    
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
