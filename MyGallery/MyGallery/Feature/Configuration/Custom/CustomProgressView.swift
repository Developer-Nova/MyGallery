//
//  CustomProgressView.swift
//  MyGallery
//
//  Created by Nova on 7/3/24.
//

import SwiftUI

struct CustomProgressView: View {
    @State private var isAnimating = false
    
    var body: some View {
        VStack {
            Spacer()
            
            Circle()
                .trim(from: 0.0, to: 0.6)
                .stroke(Color.gray, lineWidth: 5)
                .frame(width: 40, height: 40)
                .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
                .onAppear {
                    withAnimation(
                        .linear(duration: 0.7)
                        .repeatForever(autoreverses: false)
                    ) {
                        self.isAnimating = true
                    }
                }
            
            Spacer()
        } //: VStack
    }
}

#Preview {
    CustomProgressView()
        .applyBackgroundColor()
        .environment(\.backgroundColor, .customBlack0)
}
