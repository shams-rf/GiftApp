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
        
        VStack {
            
            Text("Welcome")
            
            Button("Sign out") {
                
                try! Auth.auth().signOut()
                loggedIn = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(loggedIn: .constant(Bool(true)))
    }
}
