//
//  UserView.swift
//  MyGallery
//
//  Created by Nova on 7/14/24.
//

import SwiftUI

struct UserView: View {
    var body: some View {
        Text("UserView")
            .foregroundStyle(.white)
    }
}

#Preview {
    UserView()
        .applyBackgroundColor()
        .environment(\.backgroundColor, .customBlack0)
}
