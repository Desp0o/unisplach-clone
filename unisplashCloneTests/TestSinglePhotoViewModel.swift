//
//  TestSinglePhotoViewModel.swift
//  unisplashCloneTests
//
//  Created by Despo on 27.05.25.
//

import XCTest
@testable import unisplashClone

@MainActor
final class TestSinglePhotoViewModel: XCTestCase {
  var mockNetworkManager: MockNetworkManager!
  var mockUserDefaultManager: MockUserDefaultsManager!
  var mockPhotoSaverManager: MockPhotoSaverManager!
  var sut: SingleViewModel!
  
  override func setUpWithError() throws {
    mockNetworkManager = MockNetworkManager()
    mockUserDefaultManager = MockUserDefaultsManager()
    mockPhotoSaverManager = MockPhotoSaverManager()
    sut = SingleViewModel(networkManager: mockNetworkManager, photoSaverManager: mockPhotoSaverManager, userDefaultManager: mockUserDefaultManager)
  }
  
  override func tearDownWithError() throws {
    mockNetworkManager = nil
    mockUserDefaultManager = nil
    mockPhotoSaverManager = nil
    sut = nil
  }
  
  func test_savePhoto_withSuccess() async throws {
    mockPhotoSaverManager.reset()
    mockPhotoSaverManager.shouldThrowError =  false
    
    let expectation = XCTestExpectation(description: "test download photos with success")
    Task {
      sut.savePhoto(url: "")
      try await Task.sleep(nanoseconds: 500_000_000)
      
      expectation.fulfill()
    }
    await fulfillment(of: [expectation], timeout: 1)
    
    XCTAssertTrue(sut.isSuccess)
    XCTAssertEqual(sut.message, "Download Complete")
    XCTAssertEqual(mockPhotoSaverManager.downloadedUrls.count, 1)
  }
  
  func test_savePhoto_withError() async throws {
    mockPhotoSaverManager.reset()
    mockPhotoSaverManager.shouldThrowError =  true
    
    let expectation = XCTestExpectation(description: "test download photos with error")
    Task {
      sut.savePhoto(url: "")
      try await Task.sleep(nanoseconds: 500_000_000)
      
      expectation.fulfill()
    }
    await fulfillment(of: [expectation], timeout: 1)
    
    XCTAssertTrue(sut.isError)
    XCTAssertEqual(sut.message, PhotoSaverErrorEnum.downloadFailed.rawValue)
    XCTAssertEqual(mockPhotoSaverManager.downloadedUrls.count, 0)
  }
  
  func test_getPhotoDetails_withSuccess() async throws{
    mockNetworkManager.shouldThrowError = false
    mockNetworkManager.mockResponse = SinglePhotoDetailsModel(width: 1200, height: 800, exif: Exif(make: "", model: "", name: "", exposureTime: "", aperture: "", focalLength: 1.8, iso: 100), altDescription: "", createdAt: "")
    
    let expectation = XCTestExpectation(description: "with success")
    Task {
      sut.getPhotoDetail(id: "testID")
      try await Task.sleep(nanoseconds: 500_000_000)
      
      expectation.fulfill()
    }
    await fulfillment(of: [expectation], timeout: 1)
    
    XCTAssertNotNil(sut.photoDetails)
  }
  
  func test_getPhotoDetails_withError() async throws{
    mockNetworkManager.shouldThrowError = true
    mockNetworkManager.mockResponse = SinglePhotoDetailsModel(width: 1200, height: 800, exif: Exif(make: "", model: "", name: "", exposureTime: "", aperture: "", focalLength: 1.8, iso: 100), altDescription: "", createdAt: "")
    
    let expectation = XCTestExpectation(description: "with error")
    Task {
      sut.getPhotoDetail(id: "testID")
      try await Task.sleep(nanoseconds: 500_000_000)
      
      expectation.fulfill()
    }
    await fulfillment(of: [expectation], timeout: 1)
    
    XCTAssertNil(sut.photoDetails)
    XCTAssertTrue(sut.isError)
  }
  
  func test_saveLikedPhotoInStorage() {
    let photo = PhotoResponseModel(id: "1", urls: PhotoURLsModel(regular: "", small: "", thumb: "", smallS3: ""), user: UserModel(id: "", name: "", profileImage: ProfileImageModel(small: "", medium: "", large: "")))
    sut.likedPhotos = [photo]
    
    sut.saveLikedPhotoInStorage()
    
    let savedData: Set<PhotoResponseModel>? = mockUserDefaultManager.load(for: UserDefaultsKeys.likedPhotos.rawValue)
    XCTAssertNotNil(savedData)
    XCTAssertEqual(savedData?.count, 1)
    XCTAssertEqual(savedData?.first?.id, "1")
  }
  
  func test_loadLikedPhotosFromStorage() {
    let photo = PhotoResponseModel(id: "2", urls: PhotoURLsModel(regular: "", small: "", thumb: "", smallS3: ""), user: UserModel(id: "", name: "", profileImage: ProfileImageModel(small: "", medium: "", large: "")))
    let photoSet: [PhotoResponseModel] = [photo]
    mockUserDefaultManager.set(value: photoSet, for: UserDefaultsKeys.likedPhotos.rawValue)
    
    sut.loadLikedPhotosFromStorage()
    
    XCTAssertEqual(sut.likedPhotos.count, 1)
    XCTAssertTrue(sut.likedPhotos.contains(photo))
  }
  
  func test_likePhoto_addsPhotoWhenNotLiked() {
    let photo = PhotoResponseModel(
      id: "123",
      urls: PhotoURLsModel(regular: "", small: "", thumb: "", smallS3: ""),
      user: UserModel(id: "", name: "", profileImage: ProfileImageModel(small: "", medium: "", large: ""))
    )
    
    sut.likedPhotos = []
    sut.likePhoto(photo: photo, isLiked: false)
    
    XCTAssertTrue(sut.likedPhotos.contains(photo))
    
    let savedPhotos: Set<PhotoResponseModel>? = mockUserDefaultManager.load(for: UserDefaultsKeys.likedPhotos.rawValue)
    XCTAssertEqual(savedPhotos?.count, 1)
    XCTAssertTrue(savedPhotos?.contains(photo) ?? false)
  }
  
  func test_likePhoto_removesPhotoWhenAlreadyLiked() {
    let photo = PhotoResponseModel(
      id: "456",
      urls: PhotoURLsModel(regular: "", small: "", thumb: "", smallS3: ""),
      user: UserModel(id: "", name: "", profileImage: ProfileImageModel(small: "", medium: "", large: ""))
    )
    
    sut.likedPhotos = [photo]
    sut.likePhoto(photo: photo, isLiked: true)
    
    XCTAssertFalse(sut.likedPhotos.contains(photo))
    
    let savedPhotos: [PhotoResponseModel]? = mockUserDefaultManager.load(for: UserDefaultsKeys.likedPhotos.rawValue)
    XCTAssertEqual(savedPhotos?.count, 0)
  }
}
