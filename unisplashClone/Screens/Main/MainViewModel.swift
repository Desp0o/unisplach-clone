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
  private var animationTask: Task<Void, Error>?
  var images: [PhotoResponseModel] = []
  var isDissapeared: Bool = false
  var gridMode: Bool = false
  
  init(networkManager: NetworkManagerProtocol = NetworkManager()) {
    self.networkManager = networkManager
  }
  
  func fetchImages() {
    let url = "https://api.unsplash.com/photos?page=1&per_page=10&client_id=aKp3tkGrA21Q1ViIZOSHRkuV9niWzL2pc0ACPVtX-Us"
    
    Task {
      do {
        let fetchedData: [PhotoResponseModel] = try await networkManager.networkCall(api: url)
        
        images = fetchedData
        print(images.count)
      } catch {
        print(error)
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
}
