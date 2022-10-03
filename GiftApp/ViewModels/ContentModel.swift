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
    @Published var products: [Product] = []
    
    init() {
        
        getBusinesses()
    }
    
    // Method to fetch all businesses in the database
    func getBusinesses() {
        
        let db = Firestore.firestore()
        
        let businesses = db.collection("businesses")
        
        businesses.getDocuments { querySnapshot, error in
            
            if let error = error {
                
                print(error.localizedDescription)
            }
            else if let querySnapshot = querySnapshot {
                
                var allBusinesses: [Business] = []
                
                for doc in querySnapshot.documents {
                    
                    let data = doc.data()
                    
                    let id = doc.documentID
                    let name = data["name"] as? String ?? ""
                    let address = data["address"] as? String ?? ""
                    
                    let business = Business(id: id, name: name, address: address)
                    
                    allBusinesses.append(business)
                }
                
                self.businesses = allBusinesses
            }
            else {
                
                print("No data returned")
            }
        }
    }
    
    // Method to fetch all products from a chosen business
    func getProductsByBusiness(UID: String) {
        
        let db = Firestore.firestore()
        
        let products = db.collection("products")
        
        let query = products.whereField("business", in: [UID])
        
        query.getDocuments { querySnapshot, error in
            
            if let error = error {
                
                print(error.localizedDescription)
            }
            else if let querySnapshot = querySnapshot {
                
                var allProducts: [Product] = []
                
                for doc in querySnapshot.documents {
                    
                    let data = doc.data()
                    
                    let id = doc.documentID
                    let business = data["business"] as? String ?? ""
                    let name = data["name"] as? String ?? ""
                    let description = data["description"] as? String ?? ""
                    let price = data["price"] as? String ?? ""
                    
                    let product = Product(id: id, business: business, name: name, description: description, price: price)
                    
                    allProducts.append(product)
                }
                
                self.products = allProducts
            }
            else {
                
                print("No data returned")
            }
        }
    }
    
    // Method to add products to database and link them to chosen business using businessUID
    func addProduct(UID: String, name: String, description: String, price: String) {
        
        let db = Firestore.firestore()
        
        let products = db.collection("products")
        
        products.document().setData(["business":UID, "name":name, "description":description, "price":price]) { error in
            
            if error != nil {
                
                print(error!.localizedDescription)
            }
        }
    }
}
