//
//  TestSearchViewModel.swift
//  unisplashCloneTests
//
//  Created by Despo on 27.05.25.
//

import XCTest
@testable import unisplashClone

@MainActor
final class TestSearchViewModel: XCTestCase {
  var mockNetworkManager: MockNetworkManager!
  var mockUserDefaultManager: MockUserDefaultsManager!
  var mockPhotoSaverManager: MockPhotoSaverManager!
  var sut: SearchViewModel!
  
  override func setUpWithError() throws {
    mockNetworkManager = MockNetworkManager()
    mockUserDefaultManager = MockUserDefaultsManager()
    mockPhotoSaverManager = MockPhotoSaverManager()
    sut = SearchViewModel(networkManager: mockNetworkManager, photoSaverManager: mockPhotoSaverManager, userDefaultManager: mockUserDefaultManager)
  }
  
  override func tearDownWithError() throws {
    mockNetworkManager = nil
    mockUserDefaultManager = nil
    mockPhotoSaverManager = nil
    sut = nil
    try super.tearDownWithError()
  }
  
  func test_saveHistory() {
    mockUserDefaultManager.shouldReturnError = false
    
    sut.saveHistory()
    
    if let loadedHistory: [HistoryModel] = mockUserDefaultManager.load(for: UserDefaultsKeys.searchHistory.rawValue) {
      sut.searchHistory = loadedHistory
    }
    
    XCTAssertEqual(sut.searchHistory.count, 1)
  }
  
  func test_clearHistory() {
    sut.clearSearchHistory()
    
    XCTAssertEqual(sut.searchHistory.count, 0)
  }
  
  func test_removeSingleItemFromHistory() {
      let history = HistoryModel(id: "1", keyword: "testQuery")
      mockUserDefaultManager.shouldReturnError = false
      mockUserDefaultManager.set(value: [history], for: UserDefaultsKeys.searchHistory.rawValue)
      
      sut.searchHistory = [history]
      
      sut.removeSingleItemFromHistory(id: "1")
      
      if let loadedHistory: [HistoryModel] = mockUserDefaultManager.load(for: UserDefaultsKeys.searchHistory.rawValue) {
          sut.searchHistory = loadedHistory
      }
      
      XCTAssertEqual(sut.searchHistory.count, 0)
  }

  
  func test_performSearch_withSuccess() async throws {
    mockNetworkManager.shouldThrowError = false
    mockNetworkManager.mockResponse = SearchedDataModel(total: 1, totalPage: 1, results: [PhotoResponseModel(id: "", urls: PhotoURLsModel(regular: "", small: "", thumb: "", smallS3: ""), user: UserModel(id: "", name: "", profileImage: ProfileImageModel(small: "", medium: "", large: "")))])
    
    let expectation = XCTestExpectation(description: "test with success")
    Task {
      sut.performSearch()
      
      try await Task.sleep(nanoseconds: 500_000_000)
      
      expectation.fulfill()
    }
    
    await fulfillment(of: [expectation], timeout: 1)
    
    XCTAssertFalse(sut.isLoading)
    XCTAssertFalse(sut.isResultatEmpty)
    XCTAssertEqual(sut.searchedPhotos.count, 1)
    XCTAssertEqual(sut.searchResultQuantity, 1)
  }
  
  func test_performSearch_withError() async throws {
    mockNetworkManager.shouldThrowError = true
    mockNetworkManager.mockResponse = SearchedDataModel(total: 1, totalPage: 1, results: [PhotoResponseModel(id: "", urls: PhotoURLsModel(regular: "", small: "", thumb: "", smallS3: ""), user: UserModel(id: "", name: "", profileImage: ProfileImageModel(small: "", medium: "", large: "")))])
    
    let expectation = XCTestExpectation(description: "test with success")
    Task {
      sut.performSearch()
      
      try await Task.sleep(nanoseconds: 500_000_000)
      
      expectation.fulfill()
    }
    
    await fulfillment(of: [expectation], timeout: 1)
    
    XCTAssertFalse(sut.isLoading)
    XCTAssertTrue(sut.isError)
    XCTAssertEqual(sut.searchedPhotos.count, 0)
    XCTAssertEqual(sut.searchResultQuantity, 0)
  }
  
  func test_performSearch_withEmptyResultat() async throws {
    mockNetworkManager.shouldThrowError = false
    mockNetworkManager.mockResponse = SearchedDataModel(total: 0, totalPage: 1, results: [])
    
    let expectation = XCTestExpectation(description: "test with success")
    Task {
      sut.performSearch()
      
      try await Task.sleep(nanoseconds: 500_000_000)
      
      expectation.fulfill()
    }
    
    await fulfillment(of: [expectation], timeout: 1)
    
    XCTAssertFalse(sut.isLoading)
    XCTAssertTrue(sut.isResultatEmpty)
    XCTAssertEqual(sut.searchedPhotos.count, 0)
    XCTAssertEqual(sut.searchResultQuantity, 0)
  }
  
  func test_performSearchByHistory_withSuccess() async throws {
    mockNetworkManager.shouldThrowError = false
    mockNetworkManager.mockResponse = SearchedDataModel(total: 1, totalPage: 1, results: [PhotoResponseModel(id: "", urls: PhotoURLsModel(regular: "", small: "", thumb: "", smallS3: ""), user: UserModel(id: "", name: "", profileImage: ProfileImageModel(small: "", medium: "", large: "")))])
    sut.performSearchByHistory(keyword: "test")
    
    try await Task.sleep(nanoseconds: 1_000_000_000)
    
    XCTAssertFalse(sut.isLoading)
    XCTAssertFalse(sut.isResultatEmpty)
    XCTAssertEqual(sut.searchedPhotos.count, 1)
    XCTAssertEqual(sut.searchResultQuantity, 1)
  }
  
  func test_infinityScroll_withSuccess() async throws {
    for i in 0..<7 {
      let photo = PhotoResponseModel(id: "\(i)", urls: PhotoURLsModel(regular: "", small: "", thumb: "", smallS3: ""), user: UserModel(id: "", name: "", profileImage: ProfileImageModel(small: "", medium: "", large: "")))
      
      sut.searchedPhotos.append(photo)
    }
    let lastCount = sut.searchedPhotos.count
    
    mockNetworkManager.shouldThrowError = false
    mockNetworkManager.mockResponse = SearchedDataModel(total: 1, totalPage: 1, results: [PhotoResponseModel(id: "test", urls: PhotoURLsModel(regular: "", small: "", thumb: "", smallS3: ""), user: UserModel(id: "", name: "", profileImage: ProfileImageModel(small: "", medium: "", large: "")))])
    
    sut.infinityScroll(id: "1")
    
    try await Task.sleep(nanoseconds: 500_000_000)
    
    XCTAssertFalse(sut.isLoading)
    XCTAssertFalse(sut.isResultatEmpty)
    XCTAssertEqual(sut.searchedPhotos.count, lastCount + 1)
    XCTAssertEqual(sut.searchResultQuantity, 1)
  }
  
  func test_clearSearchedResult() {
    sut.clearSearchResult()
    
    XCTAssertEqual(sut.searchResultQuantity, 0)
    XCTAssertEqual(sut.searchedPhotos.count, 0)
    XCTAssertEqual(sut.query, "")
  }
  
  func test_downloadPhotos_withSuccess() async throws {
    mockPhotoSaverManager.reset()
    mockPhotoSaverManager.shouldThrowError =  false
    sut.selectedPhotos = ["url1", "url2", "url3"]
    
    let expectation = XCTestExpectation(description: "test download photos with success")
    Task {
      sut.downloadPhotos()
      try await Task.sleep(nanoseconds: 500_000_000)
      
      expectation.fulfill()
    }
    await fulfillment(of: [expectation], timeout: 1)
    
    XCTAssertFalse(sut.isDownlaodingPhotos)
    XCTAssertTrue(sut.isSuccess)
    XCTAssertFalse(sut.isLongPressed)
    XCTAssertEqual(sut.message, "Download Complete")
    XCTAssertEqual(sut.selectedPhotos.count, 0)
    XCTAssertEqual(mockPhotoSaverManager.downloadedUrls.count, 3)
  }
}
