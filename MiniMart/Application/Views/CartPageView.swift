//
//  CartPageView.swift
//  MiniMart
//
//  Created by Tomo Watari on 2021/08/17.
//

import SwiftUI

struct CartPageView: View {
    @EnvironmentObject var cartState: CartState
    @State private var isPresented = false
    
    @Binding var isCartViewPresented: Bool
    
    
    var body: some View {
        VStack {
            List() {
                ForEach(cartState.cartItems, id: \.product.id) { cartItem in
                    HStack(alignment: .top){
                        RemoteImage(urlString: cartItem.product.imageUrl)
                            .frame(width:100, height:100)
                        VStack(alignment: .leading){
                            Text(cartItem.product.name)
                            Spacer().frame(height:8)
                            Text("\(cartItem.product.price)円")
                            Spacer()
                            Text("個数: \(cartItem.quantity)個")
                        }
                        .padding(.vertical, 8)
                    }
                }
                Text("合計金額: \(cartState.sumAmount)円")
                    .fontWeight(.bold)
                    .frame(maxWidth:.infinity, alignment: .trailing)
            }
            Button(action: {isPresented = true
            }) {
                Text("注文する")
            }
            .foregroundColor(Color.white)
            .padding(.all)
            .background(Color.orange).cornerRadius(.infinity)
            .alert(isPresented: $isPresented) {
                Alert(title: Text("注文しました"),
                      //message: Text("Thank you for shopping with us."),
                      dismissButton: .default(Text("OK"),action: {
                        self.isCartViewPresented = false
                        cartState.cartItems = []
                        cartState.sumAmount = 0
                        cartState.sumQuantity = 0
                      }))
            }
        }
        .navigationTitle("カート")
    }
}
