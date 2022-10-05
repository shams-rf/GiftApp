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
    
    var body: some View {
        
        NavigationView {
            
            ScrollView {
                
                VStack(alignment: .leading) {
                    
                    ForEach(model.products, id:\.self) { product in
                        
                        Text(product.name)
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
