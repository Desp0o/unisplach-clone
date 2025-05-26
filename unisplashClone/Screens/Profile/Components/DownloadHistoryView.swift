//
//  DownloadHistoryView.swift
//  unisplashClone
//
//  Created by Despo on 26.05.25.
//

import SwiftUI

struct DownloadHistoryView: View {
  let vm: ProfileViewModel
  
  var body: some View {
    if vm.donwloadHistory.isEmpty {
      Text("No downloads yet")
        .customTextStyle(fontColor: .customGray)
        .offset(y: 40)
    } else {
      GeometryReader { geometry in
        let photoWidth = geometry.size.width / 4 - 2

        ScrollView {
          LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 2) {
            ForEach(vm.donwloadHistory, id: \.id) { photo in
              CachedAsyncImage(url: URL(string: photo.url))
                .scaledToFill()
                .frame(width: photoWidth, height: photoWidth)
                .clipped()
            }
          }
        }
      }
      .scrollBounceBehavior(.basedOnSize)
      .scrollIndicators(.hidden)
      .onAppear {
        vm.loadDownloadHistory()
      }
    }
  }
}

#Preview {
  DownloadHistoryView(vm: ProfileViewModel())
}
