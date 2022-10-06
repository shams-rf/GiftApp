//
//  ContentModel.swift
//  GiftApp
//
//  Created by Shamsuddin Refaei on 30/09/2022.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import UIKit

class ContentModel: ObservableObject {
    
    @Published var businesses: [Business] = []
    @Published var products: [Product] = []
    @Published var productsInBasket: [Product] = []
    
    init() {
        
        //try! Auth.auth().signOut()
        
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
                    
                    // Sort array of products in alphabetical order
                    if product.name > allProducts.last?.name ?? "" {
                        
                        allProducts.append(product)
                    }
                    else {
                        
                        allProducts.insert(product, at: 0)
                    }
                }
                
                self.products = allProducts
            }
            else {
                
                print("No data returned")
            }
        }
    }
    
    // Method to add products to database and link them to chosen business using businessUID
    func addProduct(UID: String, name: String, description: String, price: String, image: UIImage) {
        
        let db = Firestore.firestore()
        
        let ref = db.collection("products").document()
        
        let productID = ref.documentID
        
        ref.setData(["business":UID, "name":name, "description":description, "price":price]) { error in
            
            if error != nil {
                
                print(error!.localizedDescription)
            }
        }
        
        storeImage(BusinessUID: UID, productID: productID, image: image)
    }
    
    // Method to store image in Firebase Storage in folder with name as business UID and image name as product ID
    func storeImage(BusinessUID: String, productID: String, image: UIImage?) {
        
        let ref = Storage.storage().reference().child("\(BusinessUID)/\(productID)")
        let imageData = image?.jpegData(compressionQuality: 0.5)
        guard imageData != nil else {
            
            return
        }
        
        ref.putData(imageData!) { metadata, error in
            
            if let error = error {
                
                print(error.localizedDescription)
            }
        }
    }
    
    // Method to edit product details
    func editProduct(BusinessUID: String, productID: String, name: String, description: String, price: String, image: UIImage) {
        
        let db = Firestore.firestore()
        
        let ref = db.collection("products").document(productID)
        
        ref.updateData(["name":name, "description":description, "price":price]) { error in
            
            if let error = error {
                
                print(error.localizedDescription)
            }
        }
        
        storeImage(BusinessUID: BusinessUID, productID: productID, image: image)
    }
    
    func getAllProducts() {
        
        let db = Firestore.firestore()
        
        let products = db.collection("products")
        
        products.getDocuments { querySnapshot, error in
            
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
        }
    }
    
    var basketCounter = 0
    
    func addToBasket(customerUID: String, productID: String) {
        
        let db = Firestore.firestore()
        
        let basket = db.collection("basket")
        
        let customer = basket.document(customerUID)
        
        customer.setData(["productID\(basketCounter)":productID], merge: true)
        
        self.basketCounter += 1
    }
    
    func getItemsInBasket(customerUID: String) {
        
        self.productsInBasket = []
        
        let db = Firestore.firestore()
        
        let basket = db.collection("basket")
        
        let doc = basket.document(customerUID)
        
        doc.getDocument { docSnapshot, error in
            
            if let error = error {
                
                print(error.localizedDescription)
            }
            else if let docSnapshot = docSnapshot {
                
                if let data = docSnapshot.data() {
                    
                    for product in data {
                        
                        let name = product.value as? String ?? ""
                        
                        self.getProductByID(productID: name)
                    }
                }
                else {
                 
                    return
                }
            }
            else {
                
                print("No data returned")
            }
        }
    }
    
    func getProductByID(productID: String) {
        
        let db = Firestore.firestore()
        
        let productRef = db.collection("products").document(productID)
        
        productRef.getDocument { docSnapshot, error in
            
            if let error = error {
                
                print(error.localizedDescription)
            }
            else if let docSnapshot = docSnapshot {
                
                if let data = docSnapshot.data() {
                    
                    let id = productID
                    let business = data["business"] as? String ?? ""
                    let name = data["name"] as? String ?? ""
                    let description = data["description"] as? String ?? ""
                    let price = data["price"] as? String ?? ""
                    
                    let product = Product(id: id, business: business, name: name, description: description, price: price)
                    
                    self.productsInBasket.append(product)
                }
                else {
                    
                    return
                }
            }
            else {
                
                print("No data returned")
            }
        }
    }
}
