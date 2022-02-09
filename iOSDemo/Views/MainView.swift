//
//  MainView.swift
//  iOSDemo
//
//  Created by zw on 2022/1/27.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    VStack {
                        Text("Menu").font(.title)
                        Image(systemName: "list.dash")
                    }
                }
            OrderView()
                .tabItem {
                    VStack {
                        Text("Order").font(.title)
                        Image(systemName: "square.and.pencil")
                    }
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
