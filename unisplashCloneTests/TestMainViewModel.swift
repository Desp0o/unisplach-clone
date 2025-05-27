//
//  TestMainViewModel.swift
//  unisplashClone
//
//  Created by Despo on 27.05.25.
//


import XCTest
@testable import unisplashClone

@MainActor
final class TestMainViewModel: XCTestCase {
  var mockNetwork: MockNetworkManager!
  var mockPhotoManager: MockPhotoSaverManager!
  var sut: MainViewModel!
  
  override func setUpWithError() throws {
    mockNetwork = MockNetworkManager()
    mockPhotoManager = MockPhotoSaverManager()
    sut = MainViewModel(networkManager: mockNetwork, photoSaverManager: mockPhotoManager)
  }
  
  override func tearDownWithError() throws {
    mockNetwork = nil
    mockPhotoManager = nil
    sut = nil
  }
  
  func test_fetchData_withSuccess() async throws {
    mockNetwork.shouldThrowError = false
    mockNetwork.mockResponse = [PhotoResponseModel(
      id: "1",
      urls: PhotoURLsModel(regular: "", small: "", thumb: "", smallS3: ""),
      user: UserModel(
        id: "",
        name: "",
        profileImage: ProfileImageModel(small: "", medium: "", large: "")
      )
    )]
    
    for _ in 0..<5 {
      sut.images.removeAll()
      
      sut.fetchImages()
      
      try await Task.sleep(nanoseconds: 1_000_000_000)
      
      XCTAssertEqual(sut.images.count, 1)
      XCTAssertFalse(sut.isLoading)
    }
  }
  
  func test_fetchData_withError() async throws {
    mockNetwork.shouldThrowError = true
    
    for _ in 0..<5 {
      sut.fetchImages()
      
      try await Task.sleep(nanoseconds: 1_000_000_000)
      
      XCTAssertEqual(sut.images.count, 0)
      XCTAssertFalse(sut.isLoading)
      XCTAssertTrue(sut.isError)
    }
  }
  
  func test_changeGridLayout_withSuccess() async throws {
    for _ in 0..<5 {
      sut.isDissapeared = false
      sut.gridMode = false
      
      sut.changeGridLayout()
      
      try await Task.sleep(nanoseconds: 100_000_000)
      XCTAssertTrue(sut.isDissapeared)
      
      try await Task.sleep(nanoseconds: 600_000_000)
      XCTAssertFalse(sut.isDissapeared)
      XCTAssertTrue(sut.gridMode)
    }
  }
  
  func test_downloadPhotos_withSuccess() async throws {
    for _ in 0..<5 {
      mockPhotoManager.reset()
      mockPhotoManager.shouldThrowError =  false
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
      XCTAssertEqual(mockPhotoManager.downloadedUrls.count, 3)
    }
  }
  
  func test_downloadPhotos_withError() async throws {
    for _ in 0..<5 {
      mockPhotoManager.reset()
      mockPhotoManager.shouldThrowError =  true
      sut.selectedPhotos = ["url1", "url2", "url3"]
      
      let expectation = XCTestExpectation(description: "test download photos with error")
      Task {
        sut.downloadPhotos()
        try await Task.sleep(nanoseconds: 500_000_000)
        
        expectation.fulfill()
      }
      await fulfillment(of: [expectation], timeout: 1)
      
      XCTAssertFalse(sut.isDownlaodingPhotos)
      XCTAssertTrue(sut.isDownloadError)
      XCTAssertEqual(sut.message, PhotoSaverErrorEnum.downloadFailed.rawValue)
      XCTAssertEqual(sut.selectedPhotos.count, 3)
      XCTAssertEqual(mockPhotoManager.downloadedUrls.count, 0)
    }
  }
}
