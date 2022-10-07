//
//  CustomerLoginForm.swift
//  GiftApp
//
//  Created by Shamsuddin Refaei on 30/09/2022.
//

import SwiftUI
import FirebaseAuth

struct CustomerLoginForm: View {
    
    @Binding var formShowing: Bool
    
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage: String?
    
    var body: some View {
        
        VStack {
            
            Text("Customer Login")
                .font(Font.custom("Comfortaa-Bold", size: 30))
            
            Image("deliveryvan")
                .resizable()
                .scaledToFit()
                .padding()
            
            Form {
                
                Section {
                    
                    TextField("Email", text: $email)
                        .font(Font.custom("Comfortaa-Regular", size: 15))
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                    
                    SecureField("Password", text: $password)
                        .font(Font.custom("Comfortaa-Regular", size: 15))
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                }
                
                if errorMessage != nil {
                    
                    Section {
                        
                        Text(errorMessage!)
                            .font(Font.custom("Comfortaa-Regular", size: 15))
                    }
                }
                
                Button {
                    
                    login()
                } label: {
                    
                    Text("Login")
                        .font(Font.custom("Comfortaa-Bold", size: 15))
                }

            }
            .cornerRadius(10)
        }
        .padding()
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

struct CustomerLoginForm_Previews: PreviewProvider {
    static var previews: some View {
        CustomerLoginForm(formShowing: .constant(Bool(true)))
    }
}
