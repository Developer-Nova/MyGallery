//
//  HomeView.swift
//  MyGallery
//
//  Created by Nova on 5/31/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var pathModel = Path()
    @StateObject private var homeViewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack(path: $pathModel.paths) {
            
        } //: NavigationStack
    }
}

#Preview {
    HomeView()
}
