//
//  CustomerProductsView.swift
//  GiftApp
//
//  Created by Shamsuddin Refaei on 01/10/2022.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct CustomerProductsView: View {
    
    @EnvironmentObject var model: ContentModel
    
    @State var showBasket = false
    
    var body: some View {
        
        NavigationView {
            
            ScrollView {
                
                VStack(alignment: .leading) {
                    
                    ForEach(model.products, id:\.self) { product in
                        
                        NavigationLink {
                            
                            CustomerProductDetailView(product: product)
                        } label: {
                            
                            CustomerProductSection(product: product)
                        }
                    }
                }
                .onAppear(perform: {
                    
                    model.getAllProducts()
                })
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    
                    ToolbarItem(placement: .principal) {
                        
                        Text("Products")
                            .font(Font.custom("Comfortaa-Bold", size: 30))
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        
                        Button {
                            
                            showBasket = true
                        } label: {
                            
                            Image(systemName: "bag")
                        }
                        .sheet(isPresented: $showBasket, onDismiss: {
                            
                            // Fetch all products if card is dismissed
                            model.getAllProducts()
                        }) {
                            
                            BasketView()
                        }
                    }
                }
            }
        }
    }
}

struct CustomerProductsView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerProductsView()
            .environmentObject(ContentModel())
    }
}
