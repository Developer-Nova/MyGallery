//
//  Environment+.swift
//  MyGallery
//
//  Created by Nova on 6/9/24.
//

import SwiftUI

extension EnvironmentValues {
    var backgroundColor: Color {
        get { self[BackgroundColorKey.self] }
        set { self[BackgroundColorKey.self] = newValue }
    }
}
