//
//  BackgoundColorModifier.swift
//  MyGallery
//
//  Created by Nova on 6/9/24.
//

import SwiftUI

struct BackgroundColorModifier: ViewModifier {
    @Environment(\.backgroundColor) var backgroundColor
    
    func body(content: Content) -> some View {
        ZStack {
            backgroundColor.edgesIgnoringSafeArea(.top)
            content
        }
    }
}
