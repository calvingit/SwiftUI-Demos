//
//  TouchLocatingView.swift
//  iOSDemo
//
//  Created by zhangwen on 2022/2/11.
//

import SwiftUI

// 封装一下UIKit的手势事件
struct TouchLocatingView: UIViewRepresentable {
    // 用户点击事件类型
    struct TouchType: OptionSet {
        let rawValue: Int
        // 点击开始
        static let started = TouchType(rawValue: 1 << 0)
        // 移动
        static let moved = TouchType(rawValue: 1 << 1)
        // 结束
        static let ended = TouchType(rawValue: 1 << 2)

        static let all: TouchType = [.started, .moved, .ended]
    }

    // 事件回调
    var onUpdate: (CGPoint, TouchType) -> Void

    // 事件类型
    var types = TouchType.all


    func makeUIView(context: Context) -> TouchLocatingUIView {
        let view = TouchLocatingUIView()
        view.onUpdate = onUpdate
        view.touchTypes = types
        return view
    }

    func updateUIView(_ uiView: TouchLocatingUIView, context: Context) {
    }

    // 内部UIView实现点击事件响应
    class TouchLocatingUIView: UIView {

        var onUpdate: ((CGPoint, TouchType) -> Void)?
        var touchTypes: TouchLocatingView.TouchType = .all

        override init(frame: CGRect) {
            super.init(frame: frame)
            isUserInteractionEnabled = true
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
            isUserInteractionEnabled = true
        }

        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            guard let touch = touches.first else { return }
            let location = touch.location(in: self)
            send(location, forEvent: .started)
        }

        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            guard let touch = touches.first else { return }
            let location = touch.location(in: self)
            send(location, forEvent: .moved)
        }

        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            guard let touch = touches.first else { return }
            let location = touch.location(in: self)
            send(location, forEvent: .ended)
        }

        override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
            guard let touch = touches.first else { return }
            let location = touch.location(in: self)
            send(location, forEvent: .ended)
        }

        // 发送指定类型的事件
        func send(_ location: CGPoint, forEvent event: TouchLocatingView.TouchType) {
            guard touchTypes.contains(event) else {
                return
            }

            if bounds.contains(location) {
                onUpdate?(location, event)
            } else {
                // 处理超出了边界的情况
                let x = min(max(0, location.x), bounds.width)
                let y = min(max(0, location.y), bounds.height)
                let point = CGPoint(x:x, y: y)
                onUpdate?(point, event)
            }
        }
    }
}

// 定义一个SwiftUI 的 modifier，在其上面overlay一个点击视图
struct TouchLocater: ViewModifier {
    var type: TouchLocatingView.TouchType = .all
    let perform: (CGPoint, TouchLocatingView.TouchType) -> Void

    func body(content: Content) -> some View {
        content
            .overlay(
                TouchLocatingView(onUpdate: perform, types: type)
            )
    }
}

// 再创建一个快捷方式
extension View {
    func onTouch(type: TouchLocatingView.TouchType = .all, perform: @escaping (CGPoint, TouchLocatingView.TouchType) -> Void) -> some View {
        self.modifier(TouchLocater(type: type, perform: perform))
    }
}

struct TouchLocatingViewPreview: View {
    struct DeviceRegion {
        var frame = CGRect(origin: .zero, size: CGSize(width: 30, height: 30))
        var isSelected = false
    }

    @State var deviceRegion = DeviceRegion()

    var body: some View {
        VStack {

            ZStack(alignment: .topLeading) {
                Rectangle()
                    .fill(Color.red)
                Circle()
                    .fill(deviceRegion.isSelected ? Color.green : Color.black)
                    .frame(width: deviceRegion.frame.width, height: deviceRegion.frame.height)
                    .offset(x: deviceRegion.frame.x, y: deviceRegion.frame.y)

                ZStack(alignment: .top) {
                    Rectangle()
                        .fill(deviceRegion.isSelected ? Color.black: Color.green)
                    Circle().fill(Color.white)
                        .frame(width: 10, height: 10, alignment: .topLeading)

                }
                //.rotationEffect(.degrees(180), anchor: .center)
                .frame(width: deviceRegion.frame.width, height: deviceRegion.frame.height)
                .offset(x: deviceRegion.frame.x, y: deviceRegion.frame.y)
            }
            .frame(width: 200, height: 200)
            .onTouch(perform: updateLocation)
        }
    }

    func updateLocation(_ location: CGPoint, type: TouchLocatingView.TouchType) {
        print(location)

        if type == .started {
            if deviceRegion.frame.contains(location) {
                deviceRegion.isSelected = true
            }
        }

        if deviceRegion.isSelected && type == .moved {
            deviceRegion.frame.centerTo(location)
            let deviceFrame = deviceRegion.frame
            if deviceRegion.frame.x < 0 {
                deviceRegion.frame = CGRect(x: 0, y: deviceFrame.y, width: deviceFrame.width, height: deviceFrame.height)
            }
            if deviceRegion.frame.y < 0 {
                deviceRegion.frame = CGRect(x: deviceFrame.x, y: 0, width: deviceFrame.width, height: deviceFrame.height)
            }
        }

        if type == .ended && deviceRegion.isSelected {
            deviceRegion.isSelected.toggle()
        }

    }
}

struct TouchLocatingView_Previews: PreviewProvider {
    static var previews: some View {
        TouchLocatingViewPreview()
    }
}
