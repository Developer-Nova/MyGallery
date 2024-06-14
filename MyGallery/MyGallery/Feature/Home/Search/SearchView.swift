//
//  SearchView.swift
//  MyGallery
//
//  Created by Nova on 6/8/24.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var searchViewModel = SearchViewModel()
    
    var body: some View {
        VStack {
            // Todo - SearchBar 구현
            
            PhotoScrollView(searchViewModel: searchViewModel)
        } //: VStack
        .applyBackgroundColor()
    }
}

// MARK: - PhotoScrollView
private struct PhotoScrollView: View {
    @ObservedObject private var searchViewModel: SearchViewModel
    
    fileprivate init(searchViewModel: SearchViewModel) {
        self.searchViewModel = searchViewModel
    }
    
    fileprivate var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: searchViewModel.columns, spacing: 3) {
                ForEach(searchViewModel.photoList, id: \.id) { item in
                    GeometryReader { geometry in
                        AsyncImage(url: URL(string: item.urls.regular)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(width: geometry.size.width, height: geometry.size.height)
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: geometry.size.width, height: geometry.size.height)
                                    .clipped()
                            case .failure(_):
                                Image(systemName: "xmark.circle")
                                    .foregroundStyle(Color.red)
                                    .frame(width: geometry.size.width, height: geometry.size.height)
                            @unknown default:
                                EmptyView()
                            }
                        } //: AsyncImage
                        .background(Color.gray)
                    } //: GeometryReader
                    .aspectRatio(0.7, contentMode: .fill)
                } //: ForEach
            } //: LazyVGrid
        } //: ScrollView
        .onAppear {
            searchViewModel.getNewPhotoList()
        }
    }
}

#Preview {
    SearchView()
        .environment(\.backgroundColor, .customBlack0)
}
