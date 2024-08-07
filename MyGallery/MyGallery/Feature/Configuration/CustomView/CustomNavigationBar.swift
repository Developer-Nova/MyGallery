//
//  CustomNavigationBar.swift
//  MyGallery
//
//  Created by Nova on 8/6/24.
//

import SwiftUI

struct CustomNavigationBar: View {
    let title: String
    let isDisplayLeftButton: Bool
    let isDisplayRightButton: Bool
    let leftButtonAction: () -> Void
    let rightButtonAction: () -> Void
    
    init(
        title: String = "title",
        isDisplayLeftButton: Bool = true,
        isDisplayRightButton: Bool = true,
        leftButtonAction: @escaping () -> Void = {},
        rightButtonAction: @escaping () -> Void = {}
    ) {
        self.title = title
        self.isDisplayLeftButton = isDisplayLeftButton
        self.isDisplayRightButton = isDisplayRightButton
        self.leftButtonAction = leftButtonAction
        self.rightButtonAction = rightButtonAction
    }
    
    var body: some View {
        HStack {
            if self.isDisplayLeftButton {
                Button(action: {
                    self.leftButtonAction()
                }, label: {
                    Image("back")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                }) //: Button
            } //: if Condition
            
            Spacer()
            
            Text(self.title)
                .foregroundStyle(.white)
                .font(.system(size: 18))
            
            Spacer()
            
            if self.isDisplayRightButton {
                Button(action: {
                    self.rightButtonAction()
                }, label: {
                    Image("share")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 25, height: 25)
                }) //: Button
            } //: if Condition
        } //: HStack
        .padding(.horizontal)
        .padding(.vertical, 10)
    }
}

#Preview {
    CustomNavigationBar()
        .applyBackgroundColor()
        .environment(\.backgroundColor, .customBlack0)
}
