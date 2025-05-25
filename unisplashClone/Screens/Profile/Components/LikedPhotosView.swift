//
//  LikedPhotosView.swift
//  unisplashClone
//
//  Created by Despo on 26.05.25.
//

import SwiftUI

struct LikedPhotosView: View {
  let vm: ProfileViewModel
  var body: some View {
    if vm.likedPhotos.isEmpty {
      Text("No photos liked yet")
        .customTextStyle(fontColor: .customGray)
        .offset(y: 40)
    } else {
      GeometryReader { geometry in
        let photoSize = geometry.size.width / 4 - 2
        ScrollView {
          LazyVGrid(columns: Array(repeating: GridItem(), count: 4)) {
            ForEach(vm.likedPhotos, id: \.id) { photo in
              CachedAsyncImage(url: URL(string: photo.urls.smallS3))
                .scaledToFill()
                .frame(width: photoSize, height: photoSize)
                .clipped()
            }
          }
        }
      }
    }
  }
}

#Preview {
  LikedPhotosView(vm: ProfileViewModel())
}
