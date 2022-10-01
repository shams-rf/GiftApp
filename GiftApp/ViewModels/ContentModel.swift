//
//  ContentModel.swift
//  GiftApp
//
//  Created by Shamsuddin Refaei on 30/09/2022.
//

import Foundation
import Firebase
import FirebaseAuth

class ContentModel: ObservableObject {
    
    @Published var businesses: [Business] = []
    
    init() {
        
        getBusinesses()
    }
    
    func getBusinesses() {
        
        let db = Firestore.firestore()
        
        let businesses = db.collection("businesses")
        
        businesses.getDocuments { querySnapshot, error in
            
            if let error = error {
                
                print(error.localizedDescription)
            }
            else if let querySnapshot = querySnapshot {
                
                for doc in querySnapshot.documents {
                    
                    let data = doc.data()
                    
                    let id = doc.documentID
                    let name = data["name"] as? String ?? ""
                    let address = data["address"] as? String ?? ""
                    
                    let business = Business(id: id, name: name, address: address)
                    
                    self.businesses.append(business)
                }
            }
            else {
                
                print("No data returned")
            }
        }
    }
}
