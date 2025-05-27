//
//  MockUserDefaultsManager.swift
//  unisplashClone
//
//  Created by Despo on 27.05.25.
//

import Foundation
@testable import unisplashClone

class MockUserDefaultsManager: UserDefaultsManagerProtocol {
  private var storage: [String: Data] = [:]
  
  func load<T: Decodable>(for key: String) -> T? {
    guard let data = storage[key] else { return nil }
    return try? JSONDecoder().decode(T.self, from: data)
  }
  
  func clear(for key: String) {
    storage.removeValue(forKey: key)
  }
  
  func set<T: Encodable>(value: T, for key: String) {
    if let encoded = try? JSONEncoder().encode(value) {
      storage[key] = encoded
    }
  }
}
