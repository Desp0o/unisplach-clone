//
//  APIEndpoinstEnum.swift
//  unisplashClone
//
//  Created by Despo on 24.05.25.
//

enum APIEndpoinstEnum {
  case fetchAllPhotos(page: Int)
  case singlePhotoDetail(id: String)
  
  var url: String {
    switch self {
    case .fetchAllPhotos(let page):
      return "https://api.unsplash.com/photos?page=\(page)&per_page=10&client_id=akXKH70mCBd9NsLvhnZEVwz8wVN0urhfmB2fKi7_ouU"
    case .singlePhotoDetail(let id):
      return "https://api.unsplash.com/photos/\(id)?client_id=akXKH70mCBd9NsLvhnZEVwz8wVN0urhfmB2fKi7_ouU"
    }
  }
}
