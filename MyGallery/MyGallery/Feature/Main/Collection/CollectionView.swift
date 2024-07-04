//
//  CollectionView.swift
//  MyGallery
//
//  Created by Nova on 6/8/24.
//

import SwiftUI

struct CollectionView: View {
    var body: some View {
        VStack {
            Text("CollectionView")
        }
        .applyBackgroundColor()
    }
}

#Preview {
    CollectionView()
        .environment(\.backgroundColor, .customBlack0)
}
