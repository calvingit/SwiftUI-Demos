//
//  ObservedObjectDemoView.swift
//  iOSDemo
//
//  Created by zhangwen on 2022/2/16.
//

import SwiftUI


class Device: ObservableObject {
    @Published var deviceRegion: TrackingRegion = TrackingRegion(xMax: 2.5, xMin: 0, yMax: 3.5, zMax: 1.5, locationZ: 0)
    @Published var subRegions: [SubRegion] = [
        SubRegion(xMax: 1.5, xMin: 0, yMax: 2.5, id: 0),
        SubRegion(xMax: 1, xMin: 0, yMax: 2, id: 1)
    ]
}

struct ObservedObjectDemoView: View {
    var body: some View {
        ZStack() {

        }
    }
}

struct ObservedObjectDemoView_Previews: PreviewProvider {
    static var previews: some View {
        ObservedObjectDemoView()
    }
}
