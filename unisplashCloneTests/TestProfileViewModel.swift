//
//  TestProfileViewModel.swift
//  unisplashCloneTests
//
//  Created by Despo on 27.05.25.
//

import XCTest
@testable import unisplashClone

final class TestProfileViewModel: XCTestCase {
  var sut: ProfileViewModel!
  var mockUserDefaultManager: MockUserDefaultsManager!
  
  override func setUpWithError() throws {
    mockUserDefaultManager = MockUserDefaultsManager()
    sut = ProfileViewModel(userDefaultManager: mockUserDefaultManager)
  }
  
  override func tearDownWithError() throws {
    mockUserDefaultManager = nil
    sut = nil
  }
  
  func test_loadHistory_withSuccess() {
    mockUserDefaultManager.shouldReturnError = false
    let mockHistory = [
      DownloadHistoryModel(id: "1", url: "url1"),
      DownloadHistoryModel(id: "2", url: "url2")
    ]
    
    mockUserDefaultManager.set(value: mockHistory, for: UserDefaultsKeys.downloadHistory.rawValue)
    
    sut.loadDownloadHistory()
    
    XCTAssertEqual(sut.donwloadHistory.count, 2)
  }
  
  func test_loadHistory_withError() {
    mockUserDefaultManager.shouldReturnError = true
    sut.loadDownloadHistory()
    
    XCTAssertEqual(sut.donwloadHistory.count, 0)
  }
  
  func test_clearDownloadHistory() {
    sut.clearDownloadHistory()
    
    XCTAssertEqual(sut.donwloadHistory.count, 0)
  }
  
  func test_loadLikedPhotos_withSuccess() {
    mockUserDefaultManager.shouldReturnError = false
    
    let mockLIkedPhotos = PhotoResponseModel(id: "", urls: PhotoURLsModel(regular: "", small: "", thumb: "", smallS3: ""), user: UserModel(id: "", name: "", profileImage: ProfileImageModel(small: "", medium: "", large: "")))
    
    mockUserDefaultManager.set(value: [mockLIkedPhotos], for: UserDefaultsKeys.likedPhotos.rawValue)

    sut.loadLikedPhotosFromStorage()
    
    XCTAssertEqual(sut.likedPhotos.count, 1)
  }
  
  func test_loadLikedPhotos_withError() {
    mockUserDefaultManager.shouldReturnError = true
    
    let mockLIkedPhotos = PhotoResponseModel(id: "", urls: PhotoURLsModel(regular: "", small: "", thumb: "", smallS3: ""), user: UserModel(id: "", name: "", profileImage: ProfileImageModel(small: "", medium: "", large: "")))
    
    mockUserDefaultManager.set(value: [mockLIkedPhotos], for: UserDefaultsKeys.likedPhotos.rawValue)

    sut.loadLikedPhotosFromStorage()
    
    XCTAssertEqual(sut.likedPhotos.count, 0)
  }
  
}
