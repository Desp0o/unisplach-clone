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
  var images: [PhotoResponseModel] = []
  
  init(networkManager: NetworkManagerProtocol = NetworkManager()) {
    self.networkManager = networkManager
  }
  
  func fetchImages() {
    let url = "https://api.unsplash.com/photos?page=1&per_page=10&client_id=aKp3tkGrA21Q1ViIZOSHRkuV9niWzL2pc0ACPVtX-Us"
    
    Task {
      do {
        let fetchedData: [PhotoResponseModel] = try await networkManager.networkCall(api: url)
        
        images = fetchedData
        print(images[0].urls.small)
      } catch {
        print(error)
      }
    }
  }
}
