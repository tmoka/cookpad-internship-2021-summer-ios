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
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                RemoteImage(urlString: product.imageUrl)
                    .frame(maxWidth: .infinity)
                    .aspectRatio(1.0, contentMode: .fill)
                VStack(alignment: .leading, spacing: 24) {
                    Text(product.name)
                        .font(.title)
                    Text("\(product.price)円")
                        .font(.title2)
                    Text(product.summary)
                        .font(.body)
                }
                Button(action: {
                    let item = CartItem(product: product, quantity:1)
                    //print(cartState.cartItems.reduce(0){$0 + $1.quantity})
                    if cartState.cartItems.contains(where: { $0.product.id == item.product.id }) {
                        let index = cartState.cartItems.firstIndex(where: { $0.product.id == item.product.id })
                        cartState.cartItems[index ?? 0].quantity += 1
                        //cartState.sumQuantity += 1
                        cartState.sumQuantity = cartState.cartItems.reduce(0){$0 + $1.quantity}
                        cartState.sumAmount = cartState.cartItems.reduce(0){$0 + ($1.quantity * $1.product.price)}
                    } else {
                        cartState.cartItems.append(item)
                        //cartState.sumQuantity += 1
                        cartState.sumQuantity = cartState.cartItems.reduce(0){$0 + $1.quantity}
                        cartState.sumAmount = cartState.cartItems.reduce(0){$0 + ($1.quantity * $1.product.price)}
                    }
                    //print(cartState.cartItems)
                }) {
                    Image(systemName: "cart.badge.plus")
                    Text("カートに追加する")
                    
                }
                .foregroundColor(Color.white)
                .frame(height: 30)
                .frame(maxWidth: .infinity)
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
                    CartPageView(isCartViewPresented: $isCartViewPresented)
                }
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
