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
        
        ScrollView {
            
            VStack {
                
                ForEach(model.productsInBasket, id:\.self) { product in

                    BasketSection(product: product)
                }
            }
            .onAppear {
                
                // Get items currently in basket
                //model.getItemsInBasket(customerUID: currentCustomerUID)
            }
        }
    }
}

struct BasketView_Previews: PreviewProvider {
    static var previews: some View {
        BasketView()
            .environmentObject(ContentModel())
    }
}
