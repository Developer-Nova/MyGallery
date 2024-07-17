//
//  RecentSearchView.swift
//  MyGallery
//
//  Created by Nova on 7/14/24.
//

import SwiftUI

struct RecentSearchView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
// MARK: - RecentSearchCellView
private struct RecentSearchCellView: View {
    private var searchText: String
    
    fileprivate init(searchText: String) {
        self.searchText = searchText
    }
    
    fileprivate var body: some View {
        VStack {
            Button(action: {
                
            }, label: {
                HStack {
                    Image("search")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 25, height: 25)
                    
                    Text(self.searchText)
                        .font(.system(size: 17))
                        .foregroundStyle(.white)
                    
                    Spacer()
                } //: HStack
                .padding(.horizontal)
            }) //: Button
            
            Divider()
                .background(.gray)
                .padding(.horizontal)
        } //: VStack
        .padding(.bottom, 5)
    }
}

#Preview {
    RecentSearchView(searchViewModel: SearchViewModel())
        .applyBackgroundColor()
        .environment(\.backgroundColor, .customBlack0)
}

#Preview("CellView") {
    RecentSearchCellView(searchText: "검색어")
        .applyBackgroundColor()
        .environment(\.backgroundColor, .customBlack0)
}
