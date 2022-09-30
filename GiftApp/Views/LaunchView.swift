//
//  LaunchView.swift
//  GiftApp
//
//  Created by Shamsuddin Refaei on 30/09/2022.
//

import SwiftUI
import FirebaseAuth

struct LaunchView: View {
    
    @State var loggedIn = false
    @State var loginFormShowing = false
    @State var createAccountFormShowing = false
    
    var body: some View {
        
        if !loggedIn {
            
            VStack(spacing: 20) {
                
                Group {
                    
                    Spacer()
                    
                    Text("Welcome to Business Login")
                        .font(.title)
                        .bold()
                    
                    Spacer()
                    
                    Text("Get started by logging in or create a new account")
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Image("deliverybike")
                        .resizable()
                        .scaledToFit()
                        .padding()
                    
                    Spacer()
                }
                
                Button {
                    
                    loginFormShowing = true
                } label: {
                    
                    ZStack {
                        
                        CustomButton()
                        
                        Text("Login")
                            .foregroundColor(.white)
                            .bold()
                    }
                }
                .sheet(isPresented: $loginFormShowing, onDismiss: checkLogin) {
                    
                    BusinessLoginForm(formShowing: $loginFormShowing)
                }
                
                Button {
                    
                    createAccountFormShowing = true
                } label: {
                    
                    ZStack {
                        
                        CustomButton()
                        
                        Text("Create Account")
                            .foregroundColor(.white)
                            .bold()
                    }
                }
                .sheet(isPresented: $createAccountFormShowing, onDismiss: checkLogin) {
                    
                    
                }
                
                Spacer()
            }
            .padding()
            .onAppear {
                
                checkLogin()
            }
        }
        else {
            
            ContentView()
        }
    }
    
    func checkLogin() {
        
        loggedIn = Auth.auth().currentUser == nil ? false : true
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
