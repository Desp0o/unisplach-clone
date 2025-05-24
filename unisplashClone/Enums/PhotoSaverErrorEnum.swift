//
//  PhotoSaverErrorEnum.swift
//  unisplashClone
//
//  Created by Despo on 24.05.25.
//


enum PhotoSaverErrorEnum: String, Error {
  case permissionDenied = "Access was denied.\nPermission is required to save images."
  case downloadFailed = "Download Failed Try Again!"
}
