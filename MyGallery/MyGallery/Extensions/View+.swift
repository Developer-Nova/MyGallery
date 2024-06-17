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
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
