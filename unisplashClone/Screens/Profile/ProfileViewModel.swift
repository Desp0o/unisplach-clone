//
//  ProfileViewModel.swift
//  unisplashClone
//
//  Created by Despo on 25.05.25.
//

import Observation
import Foundation

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

class UserDefaultsManager {
  func load<T: Decodable>(for key: String) -> T? {
    if let data = UserDefaults.standard.data(forKey: key) {
      return try? JSONDecoder().decode(T.self, from: data)
    }
    return nil
  }
  
  func clear(for key: String) {
    UserDefaults.standard.removeObject(forKey: key)
  }
  
  func set<T: Encodable>(value: T, for key: String) {
    if let encoded = try? JSONEncoder().encode(value) {
      UserDefaults.standard.set(encoded, forKey: key)
    }
  }
}
