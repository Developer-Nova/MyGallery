//
//  NoImageView.swift
//  MyGallery
//
//  Created by Nova on 7/14/24.
//

import SwiftUI

struct NoImageView: View {
    var body: some View {
        VStack {
            Spacer()
            
            Image("no_Image")
            
            Text("No Image")
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            Text("해당 검색어로 이미지를 찾을 수 없습니다.\n다른 검색어를 시도해 주세요.")
                .font(.callout)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.top, 5)
                .padding(.horizontal)
            
            Spacer()
        } //: VStack
        .foregroundStyle(Color.gray)
    }
}

#Preview {
    NoImageView()
        .applyBackgroundColor()
        .environment(\.backgroundColor, .customBlack0)
}
