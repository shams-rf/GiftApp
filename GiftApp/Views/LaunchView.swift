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
        
        if selectedView == 0 {
            
            ZStack {
                
                Rectangle()
                    .foregroundColor(Constants.pastelBlue)
                    .ignoresSafeArea()
                
                VStack {
                    
                    Spacer()
                    
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
                        
                        Button {
                            
                            self.selectedView = 1
                        } label: {
                            
                            ZStack {
                                
                                LaunchViewCustomButton()
                                
                                Text("Customer")
                                    .font(Font.custom("Comfortaa-Bold", size: 15))
                                    .foregroundColor(.white)
                            }
                        }
                        .padding()
                        
                        Button {
                            
                            self.selectedView = 2
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
        else if selectedView == 1 {
            
            CustomerLaunchView()
        }
        else if selectedView == 2 {
            
            BusinessLaunchView()
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
