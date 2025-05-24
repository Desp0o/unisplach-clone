//
//  PhotoResponseModel.swift
//  unisplashClone
//
//  Created by Despo on 24.05.25.
//

struct PhotoResponseModel: Codable {
  let id: String
  let createdAt: String?
  let blurHash: String?
  let altDescription: String?
  let urls: PhotoURLsModel
  let likes: Int
  let user: UserModel
  
  enum CodingKeys: String, CodingKey {
    case id, blurHash, urls, likes, user
    case createdAt = "created_at"
    case altDescription = "alt_description"
  }
}

struct PhotoURLsModel: Codable {
  let regular: String
  let small: String
  let thumb: String
  let smallS3: String
  
  enum CodingKeys: String, CodingKey {
    case regular, small, thumb
    case smallS3 = "small_s3"
  }
}

struct UserModel: Codable {
  let id: String
  let name: String
  let profileImage: ProfileImageModel
  
  enum CodingKeys: String, CodingKey {
    case id, name, profileImage = "profile_image"
  }
}

struct ProfileImageModel: Codable {
  let small: String
  let medium: String
  let large: String
}
