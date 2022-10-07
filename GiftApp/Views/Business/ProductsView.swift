//
//  ProductsView.swift
//  GiftApp
//
//  Created by Shamsuddin Refaei on 01/10/2022.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct ProductsView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var currentBusinessUID = Auth.auth().currentUser?.uid ?? ""
    
    @State var showAddProductView = false
    
    var body: some View {
        
        NavigationView {
            
            ScrollView {
                
                VStack(alignment: .leading) {
                    
                    if model.products == [] {
                        
                        Text("No products found, click + to add products")
                            .font(Font.custom("Comfortaa-Regular", size: 15))
                    }
                    
                    ForEach(model.products, id:\.self) { product in
                        
                        NavigationLink {
                            
                            ProductDetailView(product: product, businessUID: currentBusinessUID)
                        } label: {
                            
                            ProductSection(product: product, businessUID: currentBusinessUID)
                        }
                        .tint(.white)

                    }
                }
                .onAppear(perform: {
                    
                    model.getProductsByBusiness(UID: currentBusinessUID)
                })
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    
                    ToolbarItem(placement: .principal) {
                        
                        Text("Products")
                            .font(Font.custom("Comfortaa-Bold", size: 20))
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        
                        Button {
                            
                            showAddProductView = true
                        } label: {
                            
                            Image(systemName: "plus")
                        }
                        .sheet(isPresented: $showAddProductView, onDismiss: {
                            
                            // Fetch products for currently logged in business if card is dismissed
                            model.getProductsByBusiness(UID: currentBusinessUID)
                        }) {
                            
                            AddProductView(formShowing: $showAddProductView)
                        }
                    }
                }
            }
        }
    }
}

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView()
            .environmentObject(ContentModel())
    }
}
