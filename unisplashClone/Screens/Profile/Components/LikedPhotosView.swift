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
    }
  }
}

#Preview {
  LikedPhotosView(vm: ProfileViewModel())
}
