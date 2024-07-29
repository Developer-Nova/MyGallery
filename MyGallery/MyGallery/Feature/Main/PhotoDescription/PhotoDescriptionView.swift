//
//  PhotoDescriptionView.swift
//  MyGallery
//
//  Created by Nova on 6/10/24.
//

import SwiftUI

struct PhotoDescriptionView: View {
    @EnvironmentObject private var pathModel: Path
    private var photo: Photo
    
    init(photo: Photo) {
        self.photo = photo
    }
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    pathModel.paths.removeLast()
                }, label: {
                    Image("back")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                }) //: Button
                
                Spacer()
                
                Text("이미지 제목")
                    .foregroundStyle(.white)
                    .font(.system(size: 18))
                
                Spacer()
                
                Button(action: {
                    // Todo - 공유 버튼 기능
                }, label: {
                    Image("share")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 25, height: 25)
                }) //: Button
            } //: HStack
            .padding(.horizontal)
            .padding(.vertical, 10)
            
            ScrollView {
                Image(uiImage: photo.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .scaledToFit()
                    .clipped()
            } //: ScrollView
        } //: VStack
        .applyBackgroundColor()
    }
}

#Preview {
    PhotoDescriptionView(photo: .init(image: UIImage(systemName: "star.fill")!))
        .applyBackgroundColor()
        .environment(\.backgroundColor, .customBlack0)
}
