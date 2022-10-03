//
//  Business.swift
//  GiftApp
//
//  Created by Shamsuddin Refaei on 01/10/2022.
//

import Foundation

struct Business: Hashable, Identifiable {
    
    var id: String
    var name: String
    var address: String
}

struct Product: Hashable, Identifiable {
    
    var id: String
    var business: String
    var name: String
    var description: String
    var price: String
}
