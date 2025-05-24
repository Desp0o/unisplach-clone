//
//  SingleViewModel.swift
//  unisplashClone
//
//  Created by Despo on 24.05.25.
//

import Observation

@MainActor
@Observable
final class SingleViewModel {
  private let photoSaverManager: PhotoSaverManager
  var message: String = ""
  var isError: Bool = false
  
  init(photoSaverManager: PhotoSaverManager = PhotoSaverManager()) {
    self.photoSaverManager = photoSaverManager
  }
  
  func savePhoto(url: String) {
    Task {
      do {
        try await photoSaverManager.downloadAndSaveImages(urls: [url])
      } catch let error as PhotoSaverErrorEnum {
        message = error.rawValue
        isError = true
      }
    }
  }
}
