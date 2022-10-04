//
//  ContentView.swift
//  GiftApp
//
//  Created by Shamsuddin Refaei on 30/09/2022.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ContentView: View {
    
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
            Button("Sign out") {
                
                try! Auth.auth().signOut()
                loggedIn = false
            }
            .tabItem {
                
                VStack {
                    
                    Image(systemName: "gear")
                    
                    Text("Account")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(loggedIn: .constant(Bool(true)))
            .environmentObject(ContentModel())
    }
}
