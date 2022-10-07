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
            
            ScrollView {
                
                VStack {
                    
                    Text("Basket")
                        .font(Font.custom("Comfortaa-Bold", size: 30))
                    
                    ForEach(model.productsInBasket, id:\.self) { product in

                        BasketSection(product: product)
                    }
                }
                .padding()
                .onAppear {
                    
                    // Get items currently in basket
                    model.getItemsInBasket(customerUID: currentCustomerUID)
                }
            }
            
            Spacer()
            
            ZStack {
                
                OrderButton()
                    .font(Font.custom("Comfortaa-Bold", size: 15))
                
                Text("Buy Now")
                    .foregroundColor(.white)
            }
        }
    }
}
