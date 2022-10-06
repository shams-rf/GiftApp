//
//  BasketView.swift
//  GiftApp
//
//  Created by Shamsuddin Refaei on 05/10/2022.
//

import SwiftUI
import FirebaseAuth

struct BasketView: View {
    
    @EnvironmentObject var model:ContentModel
    
    var currentCustomerUID = Auth.auth().currentUser?.uid ?? ""
    
    var body: some View {
        
        VStack {
            
            if model.productsInBasket == [] {
                
                Text("No products in basket")
                    .font(Font.custom("Comfortaa-Regular", size: 15))
            }
            
            ForEach(model.productsInBasket, id:\.self) { product in
                
                Text(product.name)
            }
        }
        .onAppear {
            
            model.getItemsInBasket(customerUID: currentCustomerUID)
        }
    }
}

struct BasketView_Previews: PreviewProvider {
    static var previews: some View {
        BasketView()
            .environmentObject(ContentModel())
    }
}
