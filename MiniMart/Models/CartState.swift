//
//  CartState.swift
//  MiniMart
//
//  Created by Tomo Watari on 2021/08/17.
//

import Foundation
import Combine

struct CartItem {
    var product: FetchProductsQuery.Data.Product
    var quantity: Int
}

final class CartState: ObservableObject {
    @Published var cartItems: [CartItem] = []
    @Published var sumQuantity: Int = 0
    @Published var sumAmount: Int = 0
}

