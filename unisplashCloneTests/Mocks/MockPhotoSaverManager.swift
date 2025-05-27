//
//  MockPhotoSaverManager.swift
//  unisplashClone
//
//  Created by Despo on 27.05.25.
//


class MockPhotoSaverManager: PhotoSaverManagerProtocol {
    var shouldThrowError = false
    var errorToThrow: Error = PhotoSaverErrorEnum.downloadFailed
    var downloadedUrls: [String] = []
    
    func downloadAndSaveImages(urls: [String]) async throws {
        if shouldThrowError {
            throw errorToThrow
        }
        downloadedUrls.append(contentsOf: urls)
    }
    
    // Helper methods for testing
    func reset() {
        shouldThrowError = false
        downloadedUrls.removeAll()
        errorToThrow = PhotoSaverErrorEnum.downloadFailed
    }
}