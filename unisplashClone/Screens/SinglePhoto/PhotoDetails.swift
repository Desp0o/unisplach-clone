//
//  PhotoDetails.swift
//  unisplashClone
//
//  Created by Despo on 24.05.25.
//

import SwiftUI

struct PhotoDetails: View {
    var body: some View {
      VStack {
        HStack {
          
        }
        
        Divider()
          .background(.customGray)
        
        VStack(alignment: .leading) {
          Text("Camera")
            .customTextStyle(fontSize: 20, fontWeight: .semibold)
          
          HStack(alignment: .top) {
            
            VStack {
              photoDetail(key: "Make", value: "Canon")
              photoDetail(key: "Make", value: "Canon")
              photoDetail(key: "Make", value: "Canon")
              photoDetail(key: "Make", value: "Canon")
            }
            
            
            
            VStack {
              photoDetail(key: "Make", value: "Canon")
              photoDetail(key: "Make", value: "Canon")
              photoDetail(key: "Make", value: "Canon")
              photoDetail(key: "Make", value: "Canon")
            }
            
          }
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
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
    PhotoDetails()
    .preferredColorScheme(.dark)
}
