//
//  ContentView.swift
//  iOSDemo
//
//  Created by zw on 2022/1/26.
//

import SwiftUI

extension View {
    public func navBarTitle(_ title: Text, displayMode: NavigationBarItem.TitleDisplayMode = .inline) -> AnyView {
        if #available(iOS 14.0, *) {
            return AnyView(navigationTitle(title).navigationBarTitleDisplayMode(displayMode))
            
        } else {
            // Fallback on earlier versions
            return AnyView(navigationBarTitle(title, displayMode: displayMode))
        }
    }
}

struct ContentView: View {
    let menu = Bundle.main.decode([MenuSection].self, from: "menu.json")
    var body: some View {
        NavigationView {
            List {
                ForEach(menu) { section in
                    Section(header: Text(section.name)) {
                        ForEach(section.items) { item in
                            NavigationLink(destination: ItemDetail(item: item)) {
                                ItemRow(item: item)
                            }
                        }
                    }
                }
            }
            .navBarTitle(Text("title"))
            .listStyle(.grouped)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
