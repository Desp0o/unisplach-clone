//
//  PhotoResponseModel.swift
//  unisplashClone
//
//  Created by Despo on 24.05.25.
//

struct PhotoResponseModel: Codable {
  let id: String
  let urls: PhotoURLsModel
  let user: UserModel
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

struct SinglePhotoDetailsModel: Codable {
  let width: Int
  let height: Int
  let exif: Exif
  let altDescription: String?
  let createdAt: String
  
  enum CodingKeys: String, CodingKey {
    case width, height, exif
    case createdAt = "created_at"
    case altDescription = "alt_description"
  }
}

struct Exif: Codable {
  let make: String?
  let model: String?
  let name: String?
  let exposureTime: String?
  let aperture: String?
  let focalLength: Double?
  let iso: Int?
}
