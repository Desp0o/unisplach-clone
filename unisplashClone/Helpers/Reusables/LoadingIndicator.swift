//
//  LoadingIndicator.swift
//  unisplashClone
//
//  Created by Despo on 24.05.25.
//

import SwiftUI

struct LoadingIndicator: View {
  var body: some View {
    VStack {
      ProgressView()
        .scaleEffect(1.5)
        .tint(Color.primary)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}

#Preview {
  LoadingIndicator()
}
