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

// MARK: - TitleView
private struct TitleView: View {
    @EnvironmentObject private var pathModel: Path
    
    fileprivate init() { }
    
    fileprivate var body: some View {
        VStack {
            HStack {
                Text("My")
                    .strikethrough()
                
                Text("Gallery")
                
                Spacer()
                
                Button (action: {
                    pathModel.paths.append(.searchPhotoView)
                },
                 label: {
                    Image("search")
                        .resizable()
                        .frame(width: 25, height: 25)
                    
                }) //: Button
                .padding(.trailing, 7)
            } //: HStack
            .font(.title)
            .fontWeight(.bold)
            .foregroundStyle(Color.white)
            .padding(.horizontal)
            
            Rectangle()
                .frame(height: 2)
                .foregroundStyle(Color.gray.opacity(0.2))
        } //: VStack
        .padding(.top, 10)
    }
}

#Preview {
    HomeView()
        .applyBackgroundColor()
        .environment(\.backgroundColor, .customBlack0)
}
