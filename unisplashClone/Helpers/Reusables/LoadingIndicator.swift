//
//  LoadingIndicator.swift
//  unisplashClone
//
//  Created by Despo on 24.05.25.
//

import SwiftUI

struct LoadingIndicator: View {
  let isLoading: Bool
  @State private var isRotating = false
  
  var body: some View {
    if isLoading {
      VStack {
        Image(systemName: IconsEnum.loadingIcon.rawValue)
          .renderingMode(.template)
          .rotationEffect(.degrees(isRotating ? 360 : 0))
          .scaleEffect(2)
          .foregroundStyle(Color.primary)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .onAppear {
        withAnimation(.linear(duration: 1).repeatForever(autoreverses: false)) {
          isRotating = true
        }
      }
      .onDisappear {
        isRotating = false
      }
    }
  }
}



struct LoadingModifier: ViewModifier {
  let loading: LoadingIndicator
  
  public func body(content: Content) -> some View {
    content
      .overlay {
        loading
      }
  }
}
