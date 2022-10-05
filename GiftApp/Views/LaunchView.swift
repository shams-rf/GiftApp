//
//  LaunchView.swift
//  GiftApp
//
//  Created by Shamsuddin Refaei on 05/10/2022.
//

import SwiftUI

struct LaunchView: View {
    var body: some View {
        
        VStack {
            
            Text("Welcome to Gift App")
                .font(Font.custom("Comfortaa-Bold", size: 30))
            
            Image("deliverylaunchview")
                .resizable()
                .scaledToFit()
            
            Text("I am a")
                .font(Font.custom("Comfortaa-Regular", size: 15))
            
            Button {
                
                
            } label: {
                
                ZStack {
                    
                    
                }
            }

        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
