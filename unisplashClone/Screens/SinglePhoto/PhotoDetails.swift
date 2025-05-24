//
//  PhotoDetails.swift
//  unisplashClone
//
//  Created by Despo on 24.05.25.
//

import SwiftUI

struct PhotoDetails: View {
  let details: SinglePhotoDetailsModel
  
  var body: some View {
    VStack(alignment: .leading, spacing: 30) {
      HStack(alignment: .center) {
        Spacer()
        
        Text("Info")
          .customTextStyle(fontSize: 20, fontWeight: .bold)
        
        Spacer()
      }
      
      Divider()
        .background(.customGray)
      
      VStack(alignment: .leading, spacing: 10) {
        Text("Camera")
          .customTextStyle(fontSize: 20, fontWeight: .semibold)
        
        HStack(alignment: .top, spacing: 50) {
          
          VStack(alignment: .leading, spacing: 5) {
            photoDetail(key: "Make", value: details.exif.make ?? "No info")
            photoDetail(key: "Model", value: details.exif.model ?? "No info")
            photoDetail(key: "Shutter Speed (s)", value: details.exif.exposureTime ?? "No info")
            photoDetail(key: "Aperture", value: details.exif.aperture ?? "No info")
          }
          
          VStack(alignment: .leading, spacing: 5) {
            photoDetail(key: "Focal Lenght (mm)", value: details.exif.focalLength.map { "\($0)" } ?? "No info")
            photoDetail(key: "ISO", value: details.exif.iso.map { "\($0)" } ?? "No info")
            photoDetail(key: "Dimensions", value: "\(details.width) x \(details.height)")
          }
        }
      }
      .frame(maxWidth: .infinity, alignment: .topLeading)
      
      VStack(alignment: .leading, spacing: 5) {
        Text("Description")
          .customTextStyle(fontSize: 16, fontWeight: .thin)
        
        Text(details.altDescription ?? "")
          .customTextStyle(fontSize: 15, fontWeight: .semibold)
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    .padding()
    .background(.customDark)
  }
  
  @ViewBuilder
  func photoDetail(key: String, value: String) -> some View {
    VStack(alignment: .leading) {
      Text(key)
        .customTextStyle(fontSize: 16, fontWeight: .thin)
      
      Text(value)
        .customTextStyle(fontSize: 15, fontWeight: .semibold)
    }
  }
}

#Preview {
  PhotoDetails(
    details: SinglePhotoDetailsModel(
      width: 3600,
      height: 4200,
      exif: Exif(
        make: "Canon",
        model: "EOS 720D",
        name: "Canon, EOS Rebel SL3",
        exposureTime: "1/200",
        aperture: "4.0",
        focalLength: 50.0,
        iso: 100
      ),
      altDescription: "This is alt description",
      createdAt: ""
    )
  )
  .preferredColorScheme(.dark)
}
