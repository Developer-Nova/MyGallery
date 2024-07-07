//
//  TopicListRequestDTO.swift
//  MyGallery
//
//  Created by Nova on 7/7/24.
//

struct TopicListRequestDTO: RequestDTO {
    let ids: String?
    let page: Int
    let perPage: Int
    let orderBy: OrderBy
    
    init(
        ids: String? = nil,
        page: Int = 1,
        perPage: Int = 20,
        orderBy: OrderBy = .latest
    ) {
        self.ids = ids
        self.page = page
        self.perPage = perPage
        self.orderBy = orderBy
    }
    
    private enum CodingKeys: String, CodingKey {
        case ids
        case page
        case perPage = "per_page"
        case orderBy = "order_by"
    }
    
    enum OrderBy: String, Encodable {
        case featured
        case latest
        case oldest
        case position
    }
}
