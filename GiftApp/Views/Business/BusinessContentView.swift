//
//  BusinessContentView.swift
//  GiftApp
//
//  Created by Shamsuddin Refaei on 30/09/2022.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct BusinessContentView: View {
    
    @Binding var loggedIn: Bool
    
    @EnvironmentObject var model: ContentModel
    
    var currentBusinessUID = Auth.auth().currentUser?.uid ?? ""
    
    var body: some View {
        
        TabView {
            
            ProductsView()
                .tabItem {
                    
                    VStack {
                        
                        Image(systemName: "list.bullet")
                        
                        Text("Products")
                    }
                    .onAppear {
                        
                        // Get products of currently logged in business
                        model.getProductsByBusiness(UID: currentBusinessUID)
                    }
                }
            Button(action: {
                
                try! Auth.auth().signOut()
                loggedIn = false
            }, label: {
                
                Text("Sign out")
                    .font(Font.custom("Comfortaa-Regular", size: 15))
            })
            .tabItem {
                
                VStack {
                    
                    Image(systemName: "gear")
                    
                    Text("Account")
                }
            }
        }
    }
}

struct BusinessContentView_Previews: PreviewProvider {
    static var previews: some View {
        BusinessContentView(loggedIn: .constant(Bool(true)))
            .environmentObject(ContentModel())
    }
}
