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
    
    var body: some View {
        
        TabView {
            
            ProductsView()
                .tabItem {
                    
                    VStack {
                        
                        Image(systemName: "list.bullet")
                        
                        Text("Products")
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(loggedIn: .constant(Bool(true)))
    }
}
