//
//  UserDefaultsManager.swift
//  unisplashClone
//
//  Created by Despo on 26.05.25.
//

import Foundation

class UserDefaultsManager {
  func load<T: Decodable>(for key: String) -> T? {
    if let data = UserDefaults.standard.data(forKey: key) {
      return try? JSONDecoder().decode(T.self, from: data)
    }
    return nil
  }
  
  func clear(for key: String) {
    UserDefaults.standard.removeObject(forKey: key)
  }
  
  func set<T: Encodable>(value: T, for key: String) {
    if let encoded = try? JSONEncoder().encode(value) {
      UserDefaults.standard.set(encoded, forKey: key)
    }
  }
}


