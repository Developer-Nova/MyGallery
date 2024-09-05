//
//  CollectionView.swift
//  MyGallery
//
//  Created by Nova on 7/14/24.
//

import SwiftUI

struct CollectionView: View {
    var body: some View {
        ScrollView {
            CellView()
        } //: ScrollView
    }
}

private struct CellView: View {
    fileprivate init() {
        
    }
    
    fileprivate var body: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .overlay {
                VStack {
                    HStack {
                        // Todo - 사진 3개
                    } //: HStack
                    
                    
                } //: Vstack
            }
            .padding(.horizontal)
    }
}

#Preview {
    CollectionView()
        .applyBackgroundColor()
        .environment(\.backgroundColor, .customBlack0)
}
