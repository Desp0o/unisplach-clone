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
final class MainViewModel: BaseViewModel {
  private let networkManager: NetworkManagerProtocol
  private let photoSaverManager: PhotoSaverManager
  private var animationTask: Task<Void, Error>?
  var images: [PhotoResponseModel] = []
  var isDissapeared: Bool = false
  var gridMode: Bool = false
  var isLoading: Bool = true
  
  init(
    networkManager: NetworkManagerProtocol = NetworkManager(),
    photoSaverManager: PhotoSaverManager = PhotoSaverManager()
  ) {
    self.networkManager = networkManager
    self.photoSaverManager = photoSaverManager
  }
  
  func fetchImages() {
    let url = APIEndpoinstEnum.fetchAllPhotos(page: page).url
    
    Task {
      defer {
        isLoading = false
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
  
  func downloadPhotos() {
    downloadAllSelectedPhotos(manager: photoSaverManager)
  }
}
