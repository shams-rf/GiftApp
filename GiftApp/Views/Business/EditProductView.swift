//
//  EditProductView.swift
//  GiftApp
//
//  Created by Shamsuddin Refaei on 04/10/2022.
//

import SwiftUI
import FirebaseAuth

struct EditProductView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var currentBusinessUID = Auth.auth().currentUser?.uid ?? ""
    
    @Binding var formShowing: Bool
    
    var product: Product
    
    @State var name: String
    @State var description: String
    @State var price: String
    @State var errorMessage: String?
    
    @State var showImagePicker = false
    @State var image: UIImage?
    
    var body: some View {
        
        VStack {
            
            Text("Edit Product")
                .font(Font.custom("Comfortaa-Bold", size: 30))
            
            Image("deliveryscene")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 100, alignment: .center)
            
            Form {
                
                Section {
                    
                    if let image = self.image {
                        
                        Image(uiImage: image)
                            .resizable()
                            .cornerRadius(5)
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                    }
                    
                    Button(action: {
                        
                        showImagePicker = true
                    }, label: {
                        
                        Text("Add Image")
                            .font(Font.custom("Comfortaa-Bold", size: 15))
                    })
                    .sheet(isPresented: $showImagePicker, onDismiss: nil) {
                        
                        ImagePicker(image: $image)
                    }
                }
                
                Section {
                    
                    TextField(product.name, text: $name)
                        .font(Font.custom("Comfortaa-Regular", size: 15))
                    
                    TextField(product.description, text: $description)
                        .font(Font.custom("Comfortaa-Regular", size: 15))
                    
                    TextField(product.price, text: $price)
                        .font(Font.custom("Comfortaa-Regular", size: 15))
                }
                
                if errorMessage != nil {
                    
                    Section {
                        
                        Text(errorMessage!)
                            .font(Font.custom("Comfortaa-Regular", size: 15))
                    }
                }
                
                Button {
                    
                    if(name != "" && description != "" && price != "" && image != nil) {
                        
                        model.editProduct(BusinessUID: currentBusinessUID, productID: product.id, name: name, description: description, price: price, image: image!)
                        
                        formShowing = false
                    }
                    else {
                        
                        errorMessage = "Missing field"
                    }
                } label: {
                    
                    Text("Submit")
                        .font(Font.custom("Comfortaa-Bold", size: 15))
                }
            }
            .cornerRadius(10)
        }
        .padding()
    }
}

struct EditProductView_Previews: PreviewProvider {
    static var previews: some View {
        let product = Product(id: "", business: "", name: "", description: "", price: "")
        
        EditProductView(formShowing: .constant(Bool(true)), product: product, name: "", description: "", price: "")
    }
}
