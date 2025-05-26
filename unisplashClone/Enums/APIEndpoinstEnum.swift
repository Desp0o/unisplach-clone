//
//  APIEndpoinstEnum.swift
//  unisplashClone
//
//  Created by Despo on 24.05.25.
//

enum APIEndpoinstEnum {
  case fetchAllPhotos(page: Int)
  case singlePhotoDetail(id: String)
  case searchWithFilter(query: String, page: Int, order: SearchOrder, orientation: SearchOrientation)

  var url: String {
    switch self {
    case .fetchAllPhotos(let page):
      return "https://api.unsplash.com/photos?page=\(page)&per_page=10&client_id=OrK3kKtlGvc-ER5eGDXe2CvDdXI0GI_3FvDqvDDdVqA"
    case .singlePhotoDetail(let id):
      return "https://api.unsplash.com/photos/\(id)?client_id=OrK3kKtlGvc-ER5eGDXe2CvDdXI0GI_3FvDqvDDdVqA"
    case .searchWithFilter(let query, let page, let order, let orientation):
          var url = "https://api.unsplash.com/search/photos?query=\(query)&page=\(page)&per_page=20&client_id=OrK3kKtlGvc-ER5eGDXe2CvDdXI0GI_3FvDqvDDdVqA&order_by=\(order.rawValue)"
          if orientation != .all {
            url += "&orientation=\(orientation.rawValue)"
          }
          return url
        }
    }
  }
