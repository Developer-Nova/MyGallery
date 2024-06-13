//
//  View+.swift
//  MyGallery
//
//  Created by Nova on 6/9/24.
//

import SwiftUI

extension View {
    func applyBackgroundColor() -> some View {
        self.modifier(BackgroundColorModifier())
    }
}
