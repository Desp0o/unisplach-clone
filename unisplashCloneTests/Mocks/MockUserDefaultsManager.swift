//
//  MockUserDefaultsManager.swift
//  unisplashClone
//
//  Created by Despo on 27.05.25.
//

import Foundation
@testable import unisplashClone

class MockUserDefaultsManager: UserDefaultsManager {
  private var storage: [String: Data] = [:]
  var shouldReturnError: Bool = false
  
  override func load<T: Decodable>(for key: String) -> T? {
    if !shouldReturnError {
      guard let data = storage[key] else { return nil }
      return try? JSONDecoder().decode(T.self, from: data)
    } else {return nil }
  }
  
  override func clear(for key: String) {
    storage.removeValue(forKey: key)
  }
  
  override func set<T: Encodable>(value: T, for key: String) {
    if !shouldReturnError {
      if let encoded = try? JSONEncoder().encode(value) {
        storage[key] = encoded
      }
    }
  }
}
