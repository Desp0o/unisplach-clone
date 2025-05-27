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
  var likedPhotos: [PhotoResponseModel] = []
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
        message = "Can't load photo details"
        isError = true
        print(error)
      }
    }
  }
  
  
  func likePhoto(photo: PhotoResponseModel, isLiked: Bool) {
      if isLiked {
          if let index = likedPhotos.firstIndex(where: { $0.id == photo.id }) {
              likedPhotos.remove(at: index)
              saveLikedPhotoInStorage()
          }
      } else {
          if !likedPhotos.contains(where: { $0.id == photo.id }) {
              likedPhotos.append(photo)
              saveLikedPhotoInStorage()
          }
      }
  }

  
  func saveLikedPhotoInStorage() {
    userDefaultManager.set(value: likedPhotos, for: UserDefaultsKeys.likedPhotos.rawValue)
  }
  
  func loadLikedPhotosFromStorage() {
    if let data: [PhotoResponseModel] = userDefaultManager.load(for: UserDefaultsKeys.likedPhotos.rawValue) {
      likedPhotos = data
    }
  }
}
