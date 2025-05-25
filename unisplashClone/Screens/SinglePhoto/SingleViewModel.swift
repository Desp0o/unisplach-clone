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
  var photoDetails: SinglePhotoDetailsModel? = nil
  var likedPhotos: Set<PhotoResponseModel> = []
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
    if let encoded = try? JSONEncoder().encode(likedPhotos) {
      UserDefaults.standard.set(encoded, forKey: "likedPhotos")
    }
  }
  
  func loadLikedPhotosFromStorage() {
    if let data = UserDefaults.standard.data(forKey: "likedPhotos"),
       let decoded = try? JSONDecoder().decode([PhotoResponseModel].self, from: data) {
      likedPhotos = Set(decoded)
    }
  }
}
