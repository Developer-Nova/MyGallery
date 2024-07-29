//
//  Item.swift
//  MyGallery
//
//  Created by Nova on 7/29/24.
//

import SwiftUI

protocol Item: Hashable {
    var id: UUID { get }
    var image: UIImage { get }
}
