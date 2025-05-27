//
//  MockPhotoSaverManager.swift
//  unisplashClone
//
//  Created by Despo on 27.05.25.
//

@testable import unisplashClone

class MockPhotoSaverManager: PhotoSaverManager {
  var shouldThrowError = false
  var errorToThrow: Error = PhotoSaverErrorEnum.downloadFailed
  var downloadedUrls: [String] = []
  
  override func downloadAndSaveImages(urls: [String]) async throws {
    if shouldThrowError {
      throw errorToThrow
    }
    downloadedUrls.append(contentsOf: urls)
  }
  
  func reset() {
    shouldThrowError = false
    downloadedUrls.removeAll()
    errorToThrow = PhotoSaverErrorEnum.downloadFailed
  }
}
