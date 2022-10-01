//
//  CreateAccountForm.swift
//  GiftApp
//
//  Created by Shamsuddin Refaei on 01/10/2022.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct CreateAccountForm: View {
    
    @Binding var formShowing: Bool
    
    @State private var email = ""
    @State private var name = ""
    @State private var address = ""
    @State private var password = ""
    
    @State private var errorMessage: String?
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                Text("Create Account")
                    .font(.largeTitle)
                    .bold()
                
                Image("deliveryman")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250, alignment: .center)
                
                Form {
                    
                    Section {
                        
                        TextField("Email", text: $email)
                        
                        TextField("Name", text: $name)
                        
                        TextField("Address", text: $address)
                        
                        SecureField("Password", text: $password)
                    }
                    
                    if errorMessage != nil {
                        
                        Section {
                            
                            Text(errorMessage!)
                        }
                    }
                    
                    Button("Create Account") {
                        
                        createAccount()
                    }
                }
                .navigationBarHidden(true)
                .cornerRadius(10)
                
            }
            .padding()
        }
    }
    
    func createAccount() {
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            
            DispatchQueue.main.async {
                
                if error == nil {
                    
                    // Save the name & address
                    saveDetails()
                    
                    // Dismiss the form
                    formShowing = false
                }
                else {
                    
                    errorMessage = error!.localizedDescription
                }
            }
        }
    }
    
    func saveDetails() {
        
        if let currentUser = Auth.auth().currentUser {
            
            let cleansedFirstname = name.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let db = Firestore.firestore()
            
            let path = db.collection("businesses").document(currentUser.uid)
            
            path.setData(["name":cleansedFirstname, "address":address]) { error in
                
                if error == nil {
                    
                    // Saved
                }
                else {
                    
                    // Error message
                }
            }
        }
    }
}

struct CreateAccountForm_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountForm(formShowing: .constant(Bool(true)))
    }
}