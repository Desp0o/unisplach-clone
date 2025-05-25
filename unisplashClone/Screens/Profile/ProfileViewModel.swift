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
  var donwloadHistory: [DownloadHistoryModel] = []
  var likedPhotos: [Int] = []
  init() {
    loadDownloadHistory()
  }
  
  private func loadDownloadHistory() {
    if let data = UserDefaults.standard.data(forKey: "downloadHistory") {
      if let decoded = try? JSONDecoder().decode([DownloadHistoryModel].self, from: data) {
        donwloadHistory = decoded
      }
    }
  }
  
  func clearDownloadHistory() {
    UserDefaults.standard.removeObject(forKey: "downloadHistory")
    donwloadHistory = []
  }
}


