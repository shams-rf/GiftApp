//
//  CustomerLaunchView.swift
//  GiftApp
//
//  Created by Shamsuddin Refaei on 30/09/2022.
//

import SwiftUI
import FirebaseAuth

struct CustomerLaunchView: View {
    
    @State var loggedIn = false
    @State var loginFormShowing = false
    @State var createAccountFormShowing = false
    
    var body: some View {
        
        // If customer not logged in, display welcome page
        // Welcome page allows user to choose login or create account options
        if !loggedIn {
            
            ZStack {
                
                Rectangle()
                    .foregroundColor(Constants.pastelBlue)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    
                    Group {
                        
                        Spacer()
                        
                        Text("Welcome to Customer Login")
                            .font(Font.custom("Comfortaa-Bold", size: 24))
                        
                        Spacer()
                        
                        Image("customer")
                            .resizable()
                            .scaledToFit()
                            .padding()
                        
                        Spacer()
                        
                        Text("Get started by logging in or create a new account")
                            .multilineTextAlignment(.center)
                            .font(Font.custom("Comfortaa-Regular", size: 15))
                        
                        Spacer()
                    }
                    
                    Button {
                        
                        // Show login form
                        loginFormShowing = true
                    } label: {
                        
                        ZStack {
                            
                            CustomButton()
                                .foregroundColor(.blue)
                            
                            Text("Login")
                                .font(Font.custom("Comfortaa-Bold", size: 15))
                                .foregroundColor(.white)
                        }
                    }
                    .sheet(isPresented: $loginFormShowing, onDismiss: checkLogin) {
                        
                        CustomerLoginForm(formShowing: $loginFormShowing)
                    }
                    
                    Button {
                        
                        // Show create account form
                        createAccountFormShowing = true
                    } label: {
                        
                        ZStack {
                            
                            CustomButton()
                                .foregroundColor(.blue)
                            
                            Text("Create Account")
                                .font(Font.custom("Comfortaa-Bold", size: 15))
                                .foregroundColor(.white)
                                .bold()
                        }
                    }
                    .sheet(isPresented: $createAccountFormShowing, onDismiss: checkLogin) {
                        
                        CustomerCreateAccountForm(formShowing: $createAccountFormShowing)
                    }
                    
                    Spacer()
                }
                .padding()
                .onAppear {
                    
                    checkLogin()
                }
            }
        }
        else {
            
            CustomerContentView(loggedIn: $loggedIn)
        }
    }
    
    func checkLogin() {
        
        // State if a user is logged in or not
        loggedIn = Auth.auth().currentUser == nil ? false : true
    }
}

struct CustomerLaunchView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerLaunchView()
            .environmentObject(ContentModel())
    }
}
