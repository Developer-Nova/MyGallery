//
//  SearchPhotoListRequestDTO.swift
//  MyGallery
//
//  Created by Nova on 6/17/24.
//

struct SearchPhotoListRequestDTO: RequestDTO {
    let query: String
    var page: Int? = 1
    let perPage: Int = 30
    let orderBy: OrderBy? = .relevant
    let color: Colors?
    let lang: Lang = .en
    
    init(query: String, page: Int? = nil, color: Colors? = nil) {
        self.query = query
        self.page = page
        self.color = color
    }
    
    private enum CodingKeys: String, CodingKey {
        case query
        case page
        case perPage = "per_page"
        case orderBy = "order_by"
    }
    
    enum OrderBy: String, Encodable {
        case relevant
        case latest
    }
    
    enum Colors: String, Encodable {
        case blackAndWhite = "black_and_white"
        case black
        case white
        case yellow
        case orange
        case red
        case purple
        case magenta
        case green
        case teal
        case blue
    }
    
    enum Lang: String, Encodable {
        case ko
        case en
    }
}
