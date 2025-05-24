//
//  NetworkManager.swift
//  unisplashClone
//
//  Created by Despo on 24.05.25.
//

import Alamofire
import Foundation

protocol NetworkManagerProtocol {
  func networkCall<T: Decodable>(api: String) async throws -> T
}

protocol ImageNetworkProtocol {
  func downloadImageData(from urlString: String) async throws -> Data
}

final class NetworkManager: NetworkManagerProtocol, ImageNetworkProtocol {
  func networkCall<T: Decodable>(api: String) async throws -> T {
    return try await AF.request(api, method: .get)
      .validate()
      .serializingDecodable(T.self)
      .value
  }
  
  func downloadImageData(from urlString: String) async throws -> Data {
    return try await AF.request(urlString, method: .get)
      .validate()
      .serializingData()
      .value
  }
}
