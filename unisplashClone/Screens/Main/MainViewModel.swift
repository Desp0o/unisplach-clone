//
//  MainViewModel.swift
//  unisplashClone
//
//  Created by Despo on 24.05.25.
//

import Observation
import SwiftUI

@MainActor
@Observable
final class MainViewModel {
  private let networkManager: NetworkManagerProtocol
  private let photoSaverManager: PhotoSaverManager
  private var animationTask: Task<Void, Error>?
  var images: [PhotoResponseModel] = []
  var selectedPhotos: Set<String> = []
  var message: String = ""
  var page: Int = 1
  var isLongPressed: Bool = false
  var isDissapeared: Bool = false
  var gridMode: Bool = false
  var isloading: Bool = true
  var isError: Bool = false
  var isSuccess: Bool = false
  var isDownloadError: Bool = false
  var isDownlaodingPhotos: Bool = false
  
  init(
    networkManager: NetworkManagerProtocol = NetworkManager(),
    photoSaverManager: PhotoSaverManager = PhotoSaverManager()
  ) {
    self.networkManager = networkManager
    self.photoSaverManager = photoSaverManager
  }
  
  func fetchImages() {
    let url = "https://api.unsplash.com/photos?page=\(page)&per_page=10&client_id=aKp3tkGrA21Q1ViIZOSHRkuV9niWzL2pc0ACPVtX-Us"
    
    Task {
      defer {
        isloading = false
      }
      
      do {
        let fetchedData: [PhotoResponseModel] = try await networkManager.networkCall(api: url)
        
        images.append(contentsOf: fetchedData)
      } catch {
        isError = true
      }
    }
  }
  
  func changeGridLayout() {
    animationTask?.cancel()
    
    withAnimation(.smooth(duration: 0.2)) {
      isDissapeared = true
    }
    
    animationTask = Task {
      guard !Task.isCancelled else { return }
      
      try await Task.sleep(for: .milliseconds(500))
      
      guard !Task.isCancelled else { return }
      
      gridMode.toggle()
      
      withAnimation(.smooth(duration: 0.2)) {
        isDissapeared = false
      }
    }
  }
  
  func deselectImages() {
    selectedPhotos.removeAll()
    
    withAnimation {
      isLongPressed = false
    }
  }
  
  func downloadAllSelectedPhotos() {
    isDownlaodingPhotos = true
    
    Task {
      defer {
        isDownlaodingPhotos = false
      }
      
      do {
        try await photoSaverManager.downloadAndSaveImages(urls: Array(selectedPhotos))
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
