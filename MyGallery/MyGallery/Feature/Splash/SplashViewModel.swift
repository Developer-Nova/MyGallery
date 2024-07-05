//
//  SplashViewModel.swift
//  MyGallery
//
//  Created by Nova on 7/5/24.
//

import Foundation

final class SplashViewModel: ObservableObject {
    @Published private(set) var isAnimating: Bool
    
    init(
        isAnimating: Bool = false
    ) {
        self.isAnimating = isAnimating
    }
}

extension SplashViewModel {
    func changeAnimating() {
        self.isAnimating.toggle()
    }
}
