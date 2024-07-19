//
//  CollectionView.swift
//  MyGallery
//
//  Created by Nova on 7/14/24.
//

import SwiftUI

struct CollectionView: View {
    var body: some View {
        Text("CollectionView")
            .foregroundStyle(.white)
    }
}

#Preview {
    CollectionView()
        .applyBackgroundColor()
        .environment(\.backgroundColor, .customBlack0)
}
