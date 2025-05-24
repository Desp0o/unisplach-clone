//
//  LayoutPhotoView.swift
//  unisplashClone
//
//  Created by Despo on 24.05.25.
//

import SwiftUI

struct LayoutPhotoView: View {
  let url: String
  let isGridMode: Bool
  
  var body: some View {
    AsyncImage(url: URL(string: url)) { phase in
      switch phase {
      case .empty:
        ProgressView()
          .frame(height: isGridMode ? 150 : nil)
      case .success(let image):
        if isGridMode {
          image
            .resizable()
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width / 2, height: 150)
            .clipped()
        } else {
          image
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity)
        }
      case .failure:
        EmptyView()
      @unknown default:
        EmptyView()
      }
    }
  }
}
