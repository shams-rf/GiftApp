//
//  ProductDetailView.swift
//  GiftApp
//
//  Created by Shamsuddin Refaei on 03/10/2022.
//

import SwiftUI
import FirebaseStorage

struct ProductDetailView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var product: Product
    var businessUID: String
    @State var image: UIImage?
    
    @State var showEditProduct = false
    
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
                    
                    getImage(productID: product.id, businessUID: businessUID)
                }
            }
            
            Button {
                
                showEditProduct = true
            } label: {
                
                ZStack(alignment: .center) {
                    
                    Rectangle()
                        .frame(width: 150, height: 60, alignment: .center)
                        .foregroundColor(.red)
                        .cornerRadius(30)
                        .shadow(color: .gray, radius: 10, x: 10, y: 10)
                    
                    Text("Edit")
                        .font(Font.custom("Comfortaa-Bold", size: 15))
                }
            }
            .tint(.white)
            .sheet(isPresented: $showEditProduct, onDismiss: {
                
                // Fetch products for currently logged in business if card is dismissed
                model.getProductsByBusiness(UID: businessUID)
            }) {
                
                EditProductView(formShowing: $showEditProduct, product: product, name: product.name, description: product.description, price: product.price)
            }
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

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: Product(id: "", business: "", name: "Roses", description: "Red roses freshly picked", price: "4.99"), businessUID: "")
            .environmentObject(ContentModel())
    }
}
