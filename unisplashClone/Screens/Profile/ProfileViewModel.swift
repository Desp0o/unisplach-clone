//
//  ProfileViewModel.swift
//  unisplashClone
//
//  Created by Despo on 25.05.25.
//

import Observation

@Observable
final class ProfileViewModel {
  private let userDefaultManager: UserDefaultsManager
  var donwloadHistory: [DownloadHistoryModel] = []
  var likedPhotos: [PhotoResponseModel] = []
  
  init(userDefaultManager: UserDefaultsManager = UserDefaultsManager()) {
    self.userDefaultManager = userDefaultManager
    
    loadDownloadHistory()
    loadLikedPhotosFromStorage()
  }
  
  func loadDownloadHistory() {
    if let data: [DownloadHistoryModel]? = userDefaultManager.load(for: UserDefaultsKeys.downloadHistory.rawValue) {
      donwloadHistory = data ?? []
    }
  }
  
  func clearDownloadHistory() {
    userDefaultManager.clear(for: UserDefaultsKeys.downloadHistory.rawValue)
    donwloadHistory = []
  }
  
  func loadLikedPhotosFromStorage() {
    if let data: [PhotoResponseModel]? = userDefaultManager.load(for: UserDefaultsKeys.likedPhotos.rawValue) {
      likedPhotos = data ?? []
    }
  }
}
