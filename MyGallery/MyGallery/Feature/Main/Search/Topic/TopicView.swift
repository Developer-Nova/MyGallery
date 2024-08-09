//
//  TopicView.swift
//  MyGallery
//
//  Created by Nova on 8/7/24.
//

import SwiftUI

struct TopicView: View {
    @EnvironmentObject private var pathModel: Path
    @EnvironmentObject private var searchViewModel: SearchViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            HStack {
                Text("Topics")
                    .font(.system(size: 25, weight: .bold))
                    .foregroundStyle(.white)
                
                Spacer()
            } //: HStack
            .padding(.horizontal)
            
            LazyVGrid(columns: searchViewModel.topicsColumns, spacing: 10) {
                ForEach(searchViewModel.topicList, id: \.0.id) { topic, uiImage in
                    Button(action: {
                        self.pathModel.paths.append(.topicPhotoScrollView(topicTitle: topic.title))
                        self.searchViewModel.setTopicId(id: topic.id)
                        self.searchViewModel.getTopicPhotoList()
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(.black)
                                .overlay {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 180, height: 150)
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                        .clipped()
                                        .opacity(0.7)
                                }
                            
                            Text(topic.title)
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundStyle(.white)
                        } //: ZStack
                        .frame(width: 180, height: 150)
                    }) //: Button
                } //: ForEach
            } //: LazyVGrid
            .padding(.bottom, 20)
        } //: ScrollView
        .frame(maxWidth: 370)
    }
}

#Preview {
    TopicView()
}
