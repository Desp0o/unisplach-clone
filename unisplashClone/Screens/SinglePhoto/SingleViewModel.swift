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
  var isSuccess: Bool = false
  var isLoading: Bool = false
  
  init(photoSaverManager: PhotoSaverManager = PhotoSaverManager()) {
    self.photoSaverManager = photoSaverManager
  }
  
  func savePhoto(url: String) {
    isLoading = true
    
    Task {
      defer {
        isLoading = false
      }
      
      do {
        try await photoSaverManager.downloadAndSaveImages(urls: [url])
        message = "Download Complete"
        isSuccess = true
      } catch let error as PhotoSaverErrorEnum {
        message = error.rawValue
        isError = true
      }
    }
  }
}
