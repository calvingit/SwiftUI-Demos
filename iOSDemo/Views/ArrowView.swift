//
//  CustomView.swift
//  iOSDemo
//
//  Created by zw on 2022/1/29.
//

import SwiftUI

enum Position {
    case left
    case right
    case top
    case bottom
}

struct ArrowView: View {
    // 方向
    let direction: Position
    // 开始点
    let startPoint: CGPoint
    // 长度
    let length: CGFloat
    // 箭头的翅膀长度
    let arrowLength: CGFloat = 5
    
    var body: some View {
        GeometryReader { reader in
            let endPoint = endPoint()
            Path { path in
                switch direction {
                    case .left:
                        path.move(to: CGPoint(x: endPoint.x + arrowLength, y: endPoint.y - arrowLength))
                        path.addLine(to: CGPoint(x: endPoint.x, y: endPoint.y))
                        path.addLine(to: CGPoint(x: endPoint.x + arrowLength, y: endPoint.y + arrowLength))
                    case .right:
                        path.move(to: CGPoint(x: endPoint.x - arrowLength, y: endPoint.y - arrowLength))
                        path.addLine(to: CGPoint(x: endPoint.x, y: endPoint.y))
                        path.addLine(to: CGPoint(x: endPoint.x - arrowLength, y: endPoint.y + arrowLength))
                    case .top:
                        path.move(to: CGPoint(x: endPoint.x - arrowLength, y: endPoint.y + arrowLength))
                        path.addLine(to: CGPoint(x: endPoint.x, y: endPoint.y))
                        path.addLine(to: CGPoint(x: endPoint.x + arrowLength, y: endPoint.y + arrowLength))
                    case .bottom:
                        path.move(to: CGPoint(x: endPoint.x - arrowLength, y: endPoint.y - arrowLength))
                        path.addLine(to: CGPoint(x: endPoint.x, y: endPoint.y))
                        path.addLine(to: CGPoint(x: endPoint.x + arrowLength, y: endPoint.y - arrowLength))
                }
                
            }
            .stroke(Color.green)
            
            Path { path in
                path.move(to: startPoint)
                path.addLine(to: endPoint)
            }
            .stroke(Color.green)
        }
        .overlay(Rectangle().stroke(Color.red, lineWidth: 2))
    }
    
    func endPoint() -> CGPoint {
        var endPoint: CGPoint
        switch direction {
            case .left:
                endPoint = CGPoint(x: startPoint.x - length, y: startPoint.y)
            case .right:
                endPoint = CGPoint(x: startPoint.x + length, y: startPoint.y)
            case .top:
                endPoint = CGPoint(x: startPoint.x, y: startPoint.y - length)
            case .bottom:
                endPoint = CGPoint(x: startPoint.x, y: startPoint.y + length)
        }
        
        return endPoint
    }
}

struct CustomView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ArrowView(direction: .top, startPoint: CGPoint(x: 50, y: 100), length: 30).frame(width: 200, height: 200, alignment: .top).background(Color.gray)
                .previewLayout(.sizeThatFits)
            ArrowView(direction: .bottom, startPoint: CGPoint(x: 50, y: 100), length: 30).frame(width: 200, height: 200, alignment: .top).background(Color.gray)
                .previewLayout(.sizeThatFits)
            ArrowView(direction: .left, startPoint: CGPoint(x: 50, y: 100), length: 60).frame(width: 200, height: 200, alignment: .top).background(Color.gray)
                .previewLayout(.sizeThatFits)
            ArrowView(direction: .right, startPoint: CGPoint(x: 50, y: 100), length: 30).frame(width: 200, height: 200, alignment: .top).background(Color.gray)
                .previewLayout(.sizeThatFits)
        }
        
    }
}
