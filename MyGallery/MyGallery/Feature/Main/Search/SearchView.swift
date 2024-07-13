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
        
            if searchViewModel.isLoading && searchViewModel.photoList.isEmpty {
                CustomProgressView()
            } else if searchViewModel.photoList.isEmpty {
                NoImagesView()
            } else {
                PhotoScrollView(searchViewModel: searchViewModel)
            } //: if Condition
        } //: VStack
        .onAppear {
            if searchViewModel.isInitialAppear {
                searchViewModel.changeInitialAppear()
                searchViewModel.getNewPhotoList()
            }
        }
        .applyBackgroundColor()
    }
}

// MARK: - SearchBarView
private struct SearchBarView: View {
    @EnvironmentObject private var pathModel: Path
    @ObservedObject private var searchViewModel: SearchViewModel
    @FocusState private var textFieldIsFocused: Bool
    
    fileprivate init(searchViewModel: SearchViewModel) {
        self.searchViewModel = searchViewModel
    }
    
    fileprivate var body: some View {
        HStack {
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
                .onSubmit {
                    searchViewModel.removeAllToPhotoList()
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
                } //: if Condition
            } //: HStack
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .foregroundStyle(Color.customGray1)
            )
            .padding([.bottom, .trailing])
        } //: HStack
        .padding(.top, 10)
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
        ScrollView(.vertical) {
            LazyVGrid(columns: searchViewModel.columns, spacing: 3) {
                ForEach(searchViewModel.photoList, id: \.id) { photo in
                    Rectangle()
                        .overlay {
                            Image(uiImage: photo.image)
                                .resizable()
                                .scaledToFill()
                        }
                        .background(
                            Color.gray
                        )
                        .aspectRatio(0.7, contentMode: .fill)
                        .clipped()
                        .contentShape(Rectangle())
                        .onTapGesture {
                            pathModel.paths.append(.photoDescriptionView(photo: photo))
                        }
                } //: ForEach
            } //: LazyVGrid
            
            Group {
                if searchViewModel.isLoading {
                    CustomProgressView()
                } else {
                    Button(action: {
                        searchViewModel.morePhotoList(of: searchViewModel.selection)
                    }, label: {
                        Image("synchronization")
                    })
                } //: if Condition
            } //: Group
            .padding(.top, 30)
            
            Spacer()
        } //: ScrollView
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
