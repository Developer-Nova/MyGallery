//
//  SplashView.swift
//  MyGallery
//
//  Created by Nova on 7/4/24.
//

import SwiftUI

struct SplashView: View {
    @State private var splashViewModel = SplashViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("My")
                    .strikethrough()
                    .offset(x: splashViewModel.isAnimating ? 0 : -geometry.size.width)
                
                Text("Gallery")
                    .offset(x: splashViewModel.isAnimating ? 0 : geometry.size.width)
            } //: VStack
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        } //: GeometryReader
        .foregroundStyle(Color.white)
        .font(.system(size: 50, weight: .bold))
        .multilineTextAlignment(.center)
        .scaleEffect(splashViewModel.isAnimating ? 1 : 0.5)
        .opacity(splashViewModel.isAnimating ? 1 : 0)
        .onAppear {
            withAnimation(.easeInOut(duration: 0.8)) {
                splashViewModel.isAnimating.toggle()
            }
        }
        .applyBackgroundColor()
    }
}

#Preview {
    SplashView()
        .applyBackgroundColor()
        .environment(\.backgroundColor, .customBlack0)
}
