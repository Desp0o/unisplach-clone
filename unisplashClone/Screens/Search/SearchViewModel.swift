//
//  SearchViewModel.swift
//  unisplashClone
//
//  Created by Despo on 25.05.25.
//

import Observation
import Foundation
import SwiftUI

@MainActor
@Observable
final class SearchViewModel: BaseViewModel {
  private let networkManager: NetworkManagerProtocol
  private let photoSaverManager: PhotoSaverManager
  var searchedPhotos: [PhotoResponseModel] = []
  var searchHistory: [HistoryModel] = []
  var searchResultQuantity: Int = 0
  var isLoading: Bool = false
  var query: String = ""
  
  var order: SearchOrder = .relevant {
    didSet {
      searchedPhotos = []
      performSearch()
    }
  }
  var orientation: SearchOrientation = .all {
    didSet {
      searchedPhotos = []
      performSearch()
    }
  }
  
  init(
    networkManager: NetworkManagerProtocol = NetworkManager(),
    photoSaverManager: PhotoSaverManager = PhotoSaverManager()
  ) {
    self.networkManager = networkManager
    self.photoSaverManager = photoSaverManager
    super.init()
    
    loadHistory()
  }
  
  func saveHistory() {
    let history = HistoryModel(id: UUID().uuidString, keyword: query)
    
    searchHistory.insert(history, at: 0)
    if let encoded = try? JSONEncoder().encode(searchHistory) {
      UserDefaults.standard.set(encoded, forKey: "searchHistory")
    }
  }
    
  func clearSearchHistory() {
    UserDefaults.standard.removeObject(forKey: "searchHistory")
    searchHistory = []
  }
  
  func removeSingleItemFromHistory(id: String) {
      if let index = searchHistory.firstIndex(where: { $0.id == id }) {
          searchHistory.remove(at: index)
        
        if let encoded = try? JSONEncoder().encode(searchHistory) {
          UserDefaults.standard.set(encoded, forKey: "searchHistory")
        }
      }
  }
  
  private func loadHistory() {
    if let data = UserDefaults.standard.data(forKey: "searchHistory"),
       let decoded = try? JSONDecoder().decode([HistoryModel].self, from: data) {
      searchHistory = decoded
    }
  }

  func performSearch() {
    if searchedPhotos.isEmpty {
      isLoading = true
    }
    var api = "https://api.unsplash.com/search/photos?query=\(query)&page=\(page)&per_page=20&client_id=akXKH70mCBd9NsLvhnZEVwz8wVN0urhfmB2fKi7_ouU&order_by=\(order)"
    if orientation != .all {
      api += "&orientation=\(orientation.rawValue)"
    }
    
    Task {
      defer {
        isLoading = false
      }
      
      do {
        let response: SearchedDataModel = try await networkManager.networkCall(api: api)
        
        searchedPhotos.append(contentsOf: response.results)
        searchResultQuantity = response.total
        print(searchedPhotos.count)
      } catch {
        print(error.localizedDescription)
      }
    }
  }
  
  func performSearchByHistory(keyword: String) {
    query = keyword
    performSearch()
  }
  
  func infinityScroll(id: String) {
    if let index = searchedPhotos.firstIndex(where: { id == $0.id}) {
      if index == searchedPhotos.count - 6 {
        page += 1
        performSearch()
      }
    }
  }
  
  func clearSearchResult() {
    searchedPhotos = []
    searchResultQuantity = 0
    query = ""
  }
  
  func downloadPhotos() {
    downloadAllSelectedPhotos(manager: photoSaverManager)
  }
}

