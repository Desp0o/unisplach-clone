//
//  PhotoSaverManager.swift
//  unisplashClone
//
//  Created by Despo on 24.05.25.
//

import Photos
import UIKit

final class PhotoSaverManager {
  private let networkManager: ImageNetworkProtocol
  
  init(networkManager: ImageNetworkProtocol = NetworkManager()) {
    self.networkManager = networkManager
  }
  
  private func checkPermission() async -> Bool {
    let status = await PHPhotoLibrary.requestAuthorization(for: .readWrite)
    return status == .authorized || status == .limited
  }
  
  func downloadAndSaveImages(urls: [String]) async throws {
    guard await checkPermission() else {
      throw PhotoSaverErrorEnum.permissionDenied
    }
    
    for url in urls {
      do {
        let data = try await networkManager.downloadImageData(from: url)
        guard let image = UIImage(data: data) else {
          throw PhotoSaverErrorEnum.downloadFailed
        }
        try await saveImageToPhotoLibrary(image: image)
      } catch {
        throw PhotoSaverErrorEnum.downloadFailed
      }
    }
  }
  
  private func saveImageToPhotoLibrary(image: UIImage) async throws {
    try await PHPhotoLibrary.shared().performChanges {
      PHAssetChangeRequest.creationRequestForAsset(from: image)
    }
  }
}
