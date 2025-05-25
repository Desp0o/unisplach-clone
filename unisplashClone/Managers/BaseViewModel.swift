//
//  BaseViewModel.swift
//  unisplashClone
//
//  Created by Despo on 25.05.25.
//

import Observation
import SwiftUI

@Observable
class BaseViewModel {
  var selectedPhotos: Set<String> = []
  var isDownlaodingPhotos: Bool = false
  var isDownloadError: Bool = false
  var isLongPressed: Bool = false
  var isSuccess: Bool = false
  var isError: Bool = false
  var message: String = ""
  var page: Int = 1
  
  func deselectImages() {
    selectedPhotos.removeAll()
    
    withAnimation {
      isLongPressed = false
    }
  }
  
  func downloadAllSelectedPhotos(manager: PhotoSaverManager) {
    isDownlaodingPhotos = true
    
    Task {
      defer {
        isDownlaodingPhotos = false
      }
      
      do {
        try await manager.downloadAndSaveImages(urls: Array(selectedPhotos))
        message = "Download Complete"
        isSuccess = true
        selectedPhotos.removeAll()

        withAnimation {
          isLongPressed = false
        }
      } catch let error as PhotoSaverErrorEnum {
        message = error.rawValue
        isDownloadError = true
      }
    }
  }

}
