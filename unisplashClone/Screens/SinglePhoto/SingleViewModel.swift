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
  private let networkManager: NetworkManagerProtocol
  private let photoSaverManager: PhotoSaverManager
  var photoDetails: SinglePhotoDetailsModel? = nil
  var message: String = ""
  var isError: Bool = false
  var isSuccess: Bool = false
  var isLoading: Bool = false
  
  init(
    networkManager: NetworkManagerProtocol = NetworkManager(),
    photoSaverManager: PhotoSaverManager = PhotoSaverManager()
  ) {
    self.networkManager = networkManager
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
  
  func getPhotoDetail(id: String) {
    let api = APIEndpoinstEnum.singlePhotoDetail(id: id).url
    
    Task {
      do {
        let response: SinglePhotoDetailsModel = try await networkManager.networkCall(api: api)
        photoDetails = response
      } catch {
        print(error)
      }
    }
  }
}


