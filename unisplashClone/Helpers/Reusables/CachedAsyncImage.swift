//
//  CachedAsyncImage.swift
//  unisplashClone
//
//  Created by Despo on 24.05.25.
//


import UIKit
import SwiftUI

class ImageCacheManager {
  static let shared = NSCache<NSString, UIImage>()
}

struct CachedAsyncImage: View {
  let url: URL?
  
  @State private var image: UIImage? = nil
  
  var body: some View {
    Group {
      if let uiImage = image {
        Image(uiImage: uiImage)
          .resizable()
          .frame(maxWidth: .infinity, maxHeight: .infinity)
      } else {
        if let url = url {
          ProgressView()
            .frame(height: 150)
            .task {
              await loadImage(from: url)
            }
        }
      }
    }
  }
  
  private func loadImage(from url: URL) async {
    let cacheKey = url.absoluteString as NSString
    
    if let cachedImage = ImageCacheManager.shared.object(forKey: cacheKey) {
      self.image = cachedImage
      return
    }
    
    do {
      let (data, _) = try await URLSession.shared.data(from: url)
      if let downloadedImage = UIImage(data: data) {
        
        ImageCacheManager.shared.setObject(downloadedImage, forKey: cacheKey)
        
        self.image = downloadedImage
      }
    } catch {
      let _ = error
    }
  }
}
