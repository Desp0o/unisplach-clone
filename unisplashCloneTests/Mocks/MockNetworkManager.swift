//
//  MockNetworkManager.swift
//  unisplashClone
//
//  Created by Despo on 27.05.25.
//


import Foundation
import Alamofire
@testable import unisplashClone

class MockNetworkManager: NetworkManagerProtocol, ImageNetworkProtocol {
  var shouldThrowError: Bool = false
  var mockResponse: Any?
  
  func networkCall<T: Decodable>(api: String) async throws -> T {
    if shouldThrowError {
      throw AFError.createURLRequestFailed(error: NSError(domain: "Error", code: -1))
    }
    
    guard let response = mockResponse as? T else {
      throw AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength)
    }
    
    return response
  }
  
  func downloadImageData(from urlString: String) async throws -> Data {
    if shouldThrowError {
      throw AFError.createURLRequestFailed(error: NSError(domain: "Error", code: -1))
    }
    
    guard let response = mockResponse as? Data else {
      throw AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength)
    }
    
    return response
  }

}