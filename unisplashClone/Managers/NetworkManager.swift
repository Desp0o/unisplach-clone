//
//  NetworkManager.swift
//  unisplashClone
//
//  Created by Despo on 24.05.25.
//

import Alamofire

protocol NetworkManagerProtocol {
  func networkCall<T: Decodable>(api: String) async throws -> T
}

final class NetworkManager: NetworkManagerProtocol {
  func networkCall<T: Decodable>(api: String) async throws -> T {
    return try await AF.request(api, method: .get)
      .validate()
      .serializingDecodable(T.self)
      .value
  }
}
