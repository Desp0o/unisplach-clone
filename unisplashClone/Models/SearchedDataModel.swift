//
//  SearchedDataModel.swift
//  unisplashClone
//
//  Created by Despo on 25.05.25.
//

struct SearchedDataModel: Codable {
  let total: Int
  let totalPage: Int
  let results: [PhotoResponseModel]
  
  enum CodingKeys: String, CodingKey {
    case total, results
    case totalPage = "total_pages"
  }
}
