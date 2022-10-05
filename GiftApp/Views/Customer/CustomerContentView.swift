//
//  CustomerContentView.swift
//  GiftApp
//
//  Created by Shamsuddin Refaei on 30/09/2022.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct CustomerContentView: View {
    
    @Binding var loggedIn: Bool
    
    @EnvironmentObject var model: ContentModel
    
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

struct CustomerContentView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerContentView(loggedIn: .constant(Bool(true)))
            .environmentObject(ContentModel())
    }
}
