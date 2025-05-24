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
    if isGridMode {
      CachedAsyncImage(url: URL(string: url))
        .scaledToFill()
        .frame(width: UIScreen.main.bounds.width / 2, height: 150)
        .contentShape(Rectangle())
        .clipped()
    } else {
      CachedAsyncImage(url: URL(string: url))
        .scaledToFit()
        .frame(maxWidth: .infinity)
    }
  }
}
