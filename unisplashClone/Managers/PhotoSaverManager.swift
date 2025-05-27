//
//  PhotoSaverManager.swift
//  unisplashClone
//
//  Created by Despo on 24.05.25.
//

import Photos
import UIKit

protocol PhotoSaverManagerProtocol {
    func downloadAndSaveImages(urls: [String]) async throws
}

final class PhotoSaverManager: PhotoSaverManagerProtocol {
  private let networkManager: ImageNetworkProtocol
  private let userDefaultManager: UserDefaultsManager
  
  init(
    networkManager: ImageNetworkProtocol = NetworkManager(),
    userDefaultManager: UserDefaultsManager = UserDefaultsManager()
  ) {
    self.networkManager = networkManager
    self.userDefaultManager = userDefaultManager
  }
  
  private func checkPermission() async -> Bool {
    let status = await PHPhotoLibrary.requestAuthorization(for: .readWrite)
    return status == .authorized || status == .limited
  }
  
  func downloadAndSaveImages(urls: [String]) async throws {
    guard await checkPermission() else {
      throw PhotoSaverErrorEnum.permissionDenied
    }
    
    var currentHistory: [DownloadHistoryModel] = []
    if let data: [DownloadHistoryModel]? = userDefaultManager.load(for: UserDefaultsKeys.downloadHistory.rawValue) {
      currentHistory = data ?? []
    }
    
    for url in urls {
      do {
        let data = try await networkManager.downloadImageData(from: url)
        guard let image = UIImage(data: data) else {
          throw PhotoSaverErrorEnum.downloadFailed
        }
        try await saveImageToPhotoLibrary(image: image)
        
        let newData = DownloadHistoryModel(id: UUID().uuidString, url: url)
        currentHistory.append(newData)
        
        userDefaultManager.set(value: currentHistory, for: UserDefaultsKeys.downloadHistory.rawValue)
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
