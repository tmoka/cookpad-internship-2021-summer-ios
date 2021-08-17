//
//  ProductDetailPageView.swift
//  MiniMart
//
//  Created by Tomo Watari on 2021/08/17.
//

import SwiftUI

struct ProductDetailPageView: View {
    @EnvironmentObject var cartState: CartState
    @State var isCartViewPresented: Bool = false
    
    var product: FetchProductsQuery.Data.Product
    
    var body: some View {
        VStack {
            RemoteImage(urlString: product.imageUrl)
            Text(product.name)
                .font(.title)
            Text("\(product.price)円")
                .font(.title2)
            Text(product.summary)
                .font(.caption)
            Button(action: {
                let item = CartItem(product: self.product, quantity:1)
                cartState.cartItems.append(item)
                //print(cartState.cartItems.reduce(0){$0 + $1.quantity})
                if cartState.cartItems.contains(where: { $0.product.id == product.id }) {
                    let index = cartState.cartItems.firstIndex(where: { $0.product.id == product.id })
                    cartState.cartItems[index ?? 0].quantity += 1
                    cartState.sumQuantity += 1
                } else {
                    cartState.cartItems.append(item)
                    cartState.sumQuantity += 1
                }
                //print(cartState.cartItems)
            }) {
                Image(systemName: "cart.badge.plus")
                Text("カートに追加する")

            }
            .foregroundColor(Color.white)
            .padding(.all)
            .background(Color.orange).cornerRadius(10)
            
        }
        
        .navigationTitle(product.name)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {
                    self.isCartViewPresented = true
                }) {
                    Image(systemName: "cart")
                }
                Text("\(cartState.sumQuantity)")
            }
        }
        .sheet(isPresented: $isCartViewPresented) {
            NavigationView {
                CartPageView()
            }
        }
    }
}

struct ProductDetailPageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProductDetailPageView(
                product: FetchProductsQuery.Data.Product(
                    id: UUID().uuidString,
                    name: "商品 \(1)",
                    price: 100,
                    summary : "美味しい食ざい \(1)",
                    imageUrl: "https://image.cookpad-mart.com/dummy/1"
                )
            )
        }
    }
}
