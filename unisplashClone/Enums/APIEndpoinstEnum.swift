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
      return "https://api.unsplash.com/photos?page=\(page)&per_page=10&client_id=aKp3tkGrA21Q1ViIZOSHRkuV9niWzL2pc0ACPVtX-Us"
    case .singlePhotoDetail(let id):
      return "https://api.unsplash.com/photos/\(id)?client_id=aKp3tkGrA21Q1ViIZOSHRkuV9niWzL2pc0ACPVtX-Us"
    }
  }
}
