//
//  ProductsView.swift
//  GiftApp
//
//  Created by Shamsuddin Refaei on 01/10/2022.
//

import SwiftUI

struct ProductsView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                ForEach(model.businesses, id:\.self) { business in
                    
                    Text(business.name)
                }
            }
            .navigationTitle("Products")
        }
    }
}

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView()
            .environmentObject(ContentModel())
    }
}
