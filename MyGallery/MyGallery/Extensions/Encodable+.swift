//
//  Encodable+.swift
//  MyGallery
//
//  Created by Nova on 6/4/24.
//

import Foundation

extension Encodable {
    func toDictionary() throws -> [String: Any]? {
        let data = try JSONEncoder().encode(self)
        let JSONData = try JSONSerialization.jsonObject(with: data)
        return JSONData as? [String: Any]
    }
}
