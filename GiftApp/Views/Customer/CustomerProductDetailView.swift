//
//  CustomerProductDetailView.swift
//  GiftApp
//
//  Created by Shamsuddin Refaei on 06/10/2022.
//

import SwiftUI
import FirebaseStorage
import FirebaseAuth

struct CustomerProductDetailView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var currentCustomerUID = Auth.auth().currentUser?.uid ?? ""
    
    var product: Product
    @State var image: UIImage?
    
    @State var showAddToBasket = false
    
    var body: some View {
        
        VStack {
            
            ScrollView {
                
                VStack {
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        if let image = image {

                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                        }
                        
                        Text(product.name)
                            .font(Font.custom("Comfortaa-Bold", size: 30))
                            .padding(.leading)
                        
                        Text(product.description)
                            .font(Font.custom("Comfortaa-Regular", size: 15))
                            .padding(.leading)
                        
                        Text("€\(product.price)")
                            .font(Font.custom("Comfortaa-Regular", size: 15))
                            .padding(.leading)
                    }
                    
                    Spacer()
                }
                .onAppear {
                    
                    getImage(productID: product.id, businessUID: product.business)
                }
            }
            
            if showAddToBasket {
                
                HStack {
                    
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                    
                    Text("Item added to basket")
                        .font(Font.custom("Comfortaa-Regular", size: 15))
                }
            }
            
            Button {
                
                model.addToBasket(customerUID: currentCustomerUID, productID: product.id)
                
                showAddToBasket = true
            } label: {
                
                ZStack(alignment: .center) {
                    
                    OrderButton()
                    
                    Text("Add to Basket")
                        .font(Font.custom("Comfortaa-Bold", size: 15))
                }
            }
            .tint(.white)
        }
    }
    
    func getImage(productID: String, businessUID: String) {
        
        let ref = Storage.storage().reference().child("\(businessUID)/\(productID)")
        
        ref.downloadURL { url, error in
            
            if error == nil && url != nil {
                
                let data = try! Data(contentsOf: url!)
                let image = UIImage(data: data as Data)
                self.image = image
            }
            else {
                
                print(error!.localizedDescription)
            }
        }
    }
}

struct CustomerProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerProductDetailView(product: Product(id: "", business: "", name: "Roses", description: "Red roses freshly picked", price: "4.99"))
            .environmentObject(ContentModel())
    }
}
