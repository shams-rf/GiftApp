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
    
    var currentBusinessUID = Auth.auth().currentUser?.uid ?? ""
    
    @State var showAddProductView = false
    
    var body: some View {
        
        NavigationView {
            
            ScrollView {
                
                VStack(alignment: .leading) {
                    
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
