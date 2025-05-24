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
  var searchHistory: [HistoryModel] = []
  var query: String = ""
  var page: Int = 1
  var order: String = "relevant"
  
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
  
  func performSearch() {
    var api = "https://api.unsplash.com/search/photos?query=\(query)&page=\(page)&client_id=aKp3tkGrA21Q1ViIZOSHRkuV9niWzL2pc0ACPVtX-Us&order_by=\(order)"
    saveHistory()
    
    Task {
      do {
        let response: SearchedDataModel = try await networkManager.networkCall(api: api)
        
        searchedPhotos = response.results
        
      } catch {
        print(error.localizedDescription)
      }
    }
  }
}

struct HistoryModel: Codable {
  let id: String
  let keyword: String
}
