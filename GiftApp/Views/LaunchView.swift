//
//  LaunchView.swift
//  GiftApp
//
//  Created by Shamsuddin Refaei on 05/10/2022.
//

import SwiftUI

struct LaunchView: View {
    
    @State var selectedView = 0
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                Rectangle()
                    .foregroundColor(Constants.pastelBlue)
                    .ignoresSafeArea()
                
                VStack {
                    
                    Text("Welcome to Gift App")
                        .font(Font.custom("Comfortaa-Bold", size: 30))
                    
                    Spacer()
                    
                    Text("Get started by selecting an option from below")
                        .font(Font.custom("Comfortaa-Regular", size: 15))
                    
                    Image("deliverylaunchview")
                        .resizable()
                        .scaledToFit()
                    
                    Spacer()
                    
                    Text("I am a")
                        .font(Font.custom("Comfortaa-Regular", size: 15))
                    
                    HStack {
                        
                        NavigationLink {
                            
                            CustomerLaunchView()
                        } label: {
                            
                            ZStack {
                                
                                LaunchViewCustomButton()
                                
                                Text("Customer")
                                    .font(Font.custom("Comfortaa-Bold", size: 15))
                                    .foregroundColor(.white)
                            }
                        }
                        .padding()
                        
                        NavigationLink {
                            
                            BusinessLaunchView()
                        } label: {
                            
                            ZStack {
                                
                                LaunchViewCustomButton()
                                
                                Text("Business")
                                    .font(Font.custom("Comfortaa-Bold", size: 15))
                                    .foregroundColor(.white)
                            }
                        }
                        .padding()
                    }
                    
                    Spacer()
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
