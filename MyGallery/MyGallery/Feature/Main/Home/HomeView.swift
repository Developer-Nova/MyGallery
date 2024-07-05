//
//  HomeView.swift
//  MyGallery
//
//  Created by Nova on 7/4/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var homeViewModel = HomeViewModel()
    
    var body: some View {
        VStack {
            Text("Home View")
        }
        .applyBackgroundColor()
    }
}

#Preview {
    HomeView()
        .applyBackgroundColor()
        .environment(\.backgroundColor, .customBlack0)
}
