//
//  CheckoutView.swift
//  iOSDemo
//
//  Created by zw on 2022/1/27.
//

import SwiftUI

struct CheckoutView: View {
    let paymentTypes = ["Cash", "Credit Card", "iDine Points"]
    let tipAmounts = [10, 15, 20, 25, 0]
    
    @State private var paymentType = "Cash"
    @State private var addLoyaltyDetails = false
    @State private var loyaltyNumber = ""
    @State private var tipAmount = 15
    @State private var showingPaymentAlert = false
    
    @EnvironmentObject var order: Order
    
    var body: some View {
        Form {
            Section {
                Picker("How do you want to pay?", selection: $paymentType) {
                    ForEach(paymentTypes, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.wheel)
                Toggle("Add iDine loyalty card", isOn: $addLoyaltyDetails.animation())

                if addLoyaltyDetails {
                    TextField("Enter your iDine ID", text: $loyaltyNumber)
                        .foregroundColor(.red)
                }
            }
            
            Section{
                Picker("Percentage:", selection: $tipAmount) {
                    ForEach(tipAmounts, id: \.self) {
                        Text("\($0)%")
                    }
                }.pickerStyle(.segmented)
            } header: {
                Text("ADD A TIP?")
            }
            
            Section {
                Button("Confirm order") {
                    showingPaymentAlert.toggle()
                }.sheet(isPresented: $showingPaymentAlert) {
                    //
                } content: {
                    GeometryReader { geometry in
                        Color.green
                        
                        Picker("How do you want to pay?", selection: $paymentType) {
                            ForEach(paymentTypes, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: geometry.size.width, height: 200, alignment: .top)
                        .offset(y: geometry.size.height - 200)
                    }

                }

            } header: {
                Text("TOTAL: \(totalPrice)")
                    .font(.largeTitle)
            }
        }
        .navBarTitle(Text("Payment"))
        // .alert(isPresented: $showingPaymentAlert) {
        //     Alert(title: Text("Order confirmed"),
        //           message: Text("Your total was \(totalPrice) - thank you!"), dismissButton: .default(Text("OK")))
        // }

    }
    
    var totalPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        let total = Double(order.total)
        let tipValue = total / 100 * Double(tipAmount)
        
        return formatter.string(from: NSNumber(value: total + tipValue)) ?? "$0"
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView().environmentObject(Order())
    }
}
