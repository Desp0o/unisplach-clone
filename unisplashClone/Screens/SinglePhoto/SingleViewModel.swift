//
//  SingleViewModel.swift
//  unisplashClone
//
//  Created by Despo on 24.05.25.
//

import Observation
import Foundation

@MainActor
@Observable
final class SingleViewModel {
  private let networkManager: NetworkManagerProtocol
  private let photoSaverManager: PhotoSaverManager
  private let userDefaultManager: UserDefaultsManager
  var photoDetails: SinglePhotoDetailsModel? = nil
  var likedPhotos: Set<PhotoResponseModel> = []
  var message: String = ""
  var isError: Bool = false
  var isSuccess: Bool = false
  var isLoading: Bool = false
  
  init(
    networkManager: NetworkManagerProtocol = NetworkManager(),
    photoSaverManager: PhotoSaverManager = PhotoSaverManager(),
    userDefaultManager: UserDefaultsManager = UserDefaultsManager()
  ) {
    self.networkManager = networkManager
    self.photoSaverManager = photoSaverManager
    self.userDefaultManager = userDefaultManager
    
    loadLikedPhotosFromStorage()
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
        isError = true
        print(error)
      }
    }
  }
  
  
  func likePhoto(photo: PhotoResponseModel, isLiked: Bool) {
    if isLiked {
      likedPhotos.remove(photo)
      saveLikedPhotoInStorage()
    } else {
      likedPhotos.insert(photo)
      saveLikedPhotoInStorage()
    }
  }
  
  func saveLikedPhotoInStorage() {
    userDefaultManager.set(value: likedPhotos, for: UserDefaultsKeys.likedPhotos.rawValue)
  }
  
  func loadLikedPhotosFromStorage() {
    if let data: Set<PhotoResponseModel> = userDefaultManager.load(for: UserDefaultsKeys.likedPhotos.rawValue) {
      likedPhotos = data
    }
  }
}
