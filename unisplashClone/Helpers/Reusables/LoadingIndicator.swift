//
//  LoadingIndicator.swift
//  unisplashClone
//
//  Created by Despo on 24.05.25.
//

import SwiftUI

struct LoadingIndicator: View {
  let isLoading: Bool
  
  var body: some View {
    if isLoading {
      VStack {
        ProgressView()
          .scaleEffect(2)
          .tint(Color.primary)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
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
