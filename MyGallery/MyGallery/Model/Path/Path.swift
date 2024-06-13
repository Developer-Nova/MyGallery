//
//  Path.swift
//  MyGallery
//
//  Created by Nova on 6/8/24.
//

import Foundation

final class Path: ObservableObject {
    @Published var paths: [PathType]
    
    init(paths: [PathType] = []) {
        self.paths = paths
    }
}
