//
//  SwiftUIView.swift
//  iOSDemo
//
//  Created by zw on 2022/1/27.
//

import SwiftUI

struct OrderView: View {
    @EnvironmentObject var order: Order
    
    func deleteItems(at offsets: IndexSet) {
        order.items.remove(atOffsets: offsets)
    }
    
    var body: some View {
        NavigationView {
            List {
                
                Section {
                    ForEach(order.items, id: \.id) { item in
                        HStack(alignment: .top) {
                            Text(item.name)
                            Spacer()
                            Text("$\(item.price)")
                        }
                    }
                    .onDelete(perform: deleteItems)
                } header: {
                    Text("Added")
                }
                
                Section {
                    NavigationLink(destination: CheckoutView()) {
                        Text("Place Order")
                    }
                }
                .disabled(order.items.isEmpty)
            }
            .navBarTitle(Text("Order"))
            .listStyle(.automatic)
            .navigationBarItems(trailing: EditButton())
        }
    }
}
struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView().environmentObject(Order())
    }
}
