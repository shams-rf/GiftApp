//
//  BusinessLoginForm.swift
//  GiftApp
//
//  Created by Shamsuddin Refaei on 30/09/2022.
//

import SwiftUI
import FirebaseAuth

struct BusinessLoginForm: View {
    
    @Binding var formShowing: Bool
    
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage: String?
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                Text("Business Login")
                    .font(.largeTitle)
                    .bold()
                
                Image("deliveryvan")
                    .resizable()
                    .scaledToFit()
                    .padding()
                
                Form {
                    
                    Section {
                        
                        TextField("Email", text: $email)
                        
                        SecureField("Password", text: $password)
                    }
                    
                    if errorMessage != nil {
                        
                        Section {
                            
                            Text(errorMessage!)
                        }
                    }
                    
                    Button("Login") {
                        
                        login()
                    }
                }
                .navigationBarHidden(true)
                .cornerRadius(10)
                
            }
            .padding()
        }
    }
    
    func login() {
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            
            DispatchQueue.main.async {
                
                if error == nil {
                    
                    // Sign in successful
                    
                    // Dismiss the sheet
                    formShowing = false
                }
                else {
                    
                    // If there's an issue with logging in
                    errorMessage = error!.localizedDescription
                }
            }
        }
    }
}

struct BusinessLoginForm_Previews: PreviewProvider {
    static var previews: some View {
        BusinessLoginForm(formShowing: .constant(Bool(true)))
    }
}
