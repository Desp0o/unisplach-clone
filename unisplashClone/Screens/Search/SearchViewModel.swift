//
//  SearchViewModel.swift
//  unisplashClone
//
//  Created by Despo on 25.05.25.
//

import Observation
import Foundation

@MainActor
@Observable
final class SearchViewModel {
  private let networkManager: NetworkManagerProtocol
  var searchedPhotos: [PhotoResponseModel] = []
  var searchResultQuantity: Int = 0
  var searchHistory: [HistoryModel] = []
  var isLoading: Bool = false
  var isLongPressed: Bool = false
  var query: String = ""
  var page: Int = 1
  var order: SearchOrder = .relevant {
    didSet {
      performSearch()
    }
  }
  var orientation: SearchOrientation = .all {
    didSet {
      performSearch()
    }
  }
  
  init(networkManager: NetworkManagerProtocol = NetworkManager()) {
    self.networkManager = networkManager
    
    loadHistory()
  }
  
  func saveHistory() {
    let history = HistoryModel(id: UUID().uuidString, keyword: query)
    
    searchHistory.insert(history, at: 0)
    if let encoded = try? JSONEncoder().encode(searchHistory) {
      UserDefaults.standard.set(encoded, forKey: "searchHistory")
    }
  }
  
  private func loadHistory() {
    if let data = UserDefaults.standard.data(forKey: "searchHistory"),
       let decoded = try? JSONDecoder().decode([HistoryModel].self, from: data) {
      searchHistory = decoded
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
  
  func performSearch() {
    isLoading = true
    var api = "https://api.unsplash.com/search/photos?query=\(query)&page=\(page)&client_id=aKp3tkGrA21Q1ViIZOSHRkuV9niWzL2pc0ACPVtX-Us&order_by=\(order)"
    if orientation != .all {
      api += "&orientation=\(orientation.rawValue)"
    }
    
    Task {
      defer {
        isLoading = false
      }
      
      do {
        let response: SearchedDataModel = try await networkManager.networkCall(api: api)
        
        searchedPhotos = response.results
        searchResultQuantity = response.total
        
      } catch {
        print(error.localizedDescription)
      }
    }
  }
  
  func performSearchByHistory(keyword: String) {
    page = 1
    query = keyword
    order = .relevant
    orientation = .all
    
    performSearch()
  }
  
  func clearSearchResult() {
    searchedPhotos = []
    searchResultQuantity = 0
  }
}

