//
//  MoreButtonView.swift
//  MyGallery
//
//  Created by Nova on 7/15/24.
//

import SwiftUI

struct MoreButtonView: View {
    let title: String
    let action: () -> Void
    
    init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
    
    var body: some View {
        VStack {
            Button(action: {
                self.action()
            }, label: {
                Text(self.title)
                    .font(.system(size: 15))
                    .padding(.horizontal)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(.gray.opacity(0.3))
                            .frame(width: 110, height: 40)
                    )
                    .foregroundStyle(.customGray2)
            }) //: Button
        } //: VStack
    }
}

#Preview {
    MoreButtonView(title: "title", action: { print("action") })
}
