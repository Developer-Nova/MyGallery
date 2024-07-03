//
//  SearchView.swift
//  MyGallery
//
//  Created by Nova on 6/8/24.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject private var pathModel: Path
    @StateObject private var searchViewModel = SearchViewModel()
    
    var body: some View {
        VStack {
            SearchBarView(searchViewModel: searchViewModel)
            
            if !searchViewModel.isLoading {
                PhotoScrollView(searchViewModel: searchViewModel)
            } else {
                CustomProgressView()
            }
        } //: VStack
        .onAppear {
            searchViewModel.clearSearchBarAndLoadImages()
            searchViewModel.getNewPhotoList()
        }
        .applyBackgroundColor()
    }
}

// MARK: - SearchBarView
private struct SearchBarView: View {
    @ObservedObject private var searchViewModel: SearchViewModel
    
    fileprivate init(searchViewModel: SearchViewModel) {
        self.searchViewModel = searchViewModel
    }
    
    fileprivate var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color.customGray2)
            
            TextField(
                "Search",
                text: $searchViewModel.searchText,
                prompt: Text("Search for photos")
                            .foregroundStyle(Color.customGray2)
            )
            .foregroundStyle(Color.customGray2)
            .submitLabel(.search)
            .autocorrectionDisabled()
            .onChange(of: searchViewModel.searchText) { _, newValue in
                if newValue.isEmpty {
                    searchViewModel.getNewPhotoList()
                }
            }
            .onSubmit {
                searchViewModel.getSearchPhotoList()
            }
            
            if !searchViewModel.searchText.isEmpty {
                Button(action: {
                    searchViewModel.clearSearchBarAndLoadImages()
                    hideKeyboard()
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(Color.customGray2)
                })
            }
        } //: HStack
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .foregroundStyle(Color.customGray1)
        )
        .padding()
    }
}

// MARK: - PhotoScrollView
private struct PhotoScrollView: View {
    @EnvironmentObject private var pathModel: Path
    @ObservedObject private var searchViewModel: SearchViewModel
    
    fileprivate init(searchViewModel: SearchViewModel) {
        self.searchViewModel = searchViewModel
    }
    
    fileprivate var body: some View {
        if !searchViewModel.isEmptyImage {
            ScrollView(.vertical) {
                LazyVGrid(columns: searchViewModel.columns, spacing: 3) {
                    ForEach(searchViewModel.photoList, id: \.id) { photo in
                        Rectangle()
                            .overlay {
                                Image(uiImage: photo.image)
                                    .resizable()
                                    .scaledToFill()
                            }
                            .aspectRatio(0.7, contentMode: .fill)
                            .clipped()
                            .contentShape(Rectangle())
                            .onTapGesture {
                                pathModel.paths.append(.photoDescriptionView(photo: photo))
                            }
                    } //: ForEach
                } //: LazyVGrid
            } //: ScrollView
        } else {
            NoImagesView()
        }
    }
}

// MARK: - NoImagesView
private struct NoImagesView: View {
    
    fileprivate init() { }
    
    fileprivate var body: some View {
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
    SearchView()
        .environment(\.backgroundColor, .customBlack0)
        .environmentObject(Path())
}

#Preview("NoImagesView") {
    NoImagesView()
        .applyBackgroundColor()
        .environment(\.backgroundColor, .customBlack0)
}
