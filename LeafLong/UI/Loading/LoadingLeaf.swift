//
//  LoadingLeaf.swift
//  LeafLong
//
//  Created by Daneo Van Overloop on 17/08/2024.
//

import SwiftUI

struct LeafColor: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let startOfImage = CGPoint(x: rect.midX, y: rect.minY)
        // Radius of the outer circle
        let circleRadius = min(rect.width, rect.height) / 4 * 0.8
        // Center of the flower
        let circleCenter = CGPoint(x: rect.midX, y: startOfImage.y + circleRadius)
        
        // Define the leaf shape using Bezier curves
        path.move(to: CGPoint(x: circleCenter.x, y: rect.maxY))
        
        // Draw inner leaves
        path.addCurve(to: CGPoint(x: circleCenter.x, y: rect.maxY),
                      control1: CGPoint(x: rect.maxX, y: rect.minY + rect.height * 0.2),
                      control2: CGPoint(x: rect.maxX, y: rect.maxY - rect.height * 0.1))
        
        path.addCurve(to: CGPoint(x: circleCenter.x, y: rect.maxY),
                      control1: CGPoint(x: rect.minX, y: rect.minY + rect.height * 0.2),
                      control2: CGPoint(x: rect.minX, y: rect.maxY - rect.height * 0.2))
        
        // Draw outer leaves
        path.addCurve(to: CGPoint(x: circleCenter.x, y: rect.maxY),
                      control1: CGPoint(x: rect.minX - rect.midX * 0.4, y: circleCenter.y * 3),
                      control2: CGPoint(x: rect.minX + rect.minX * 0.175, y: circleCenter.y))
        path.addCurve(to: CGPoint(x: rect.midX, y: rect.maxY),
                      control1: CGPoint(x: rect.maxX + rect.midX * 0.4, y: circleCenter.y * 3),
                      control2: CGPoint(x: rect.maxX - rect.minX * 0.175, y: circleCenter.y))

        
        // Calculate where the circle will start to keep the fluid "drawing" animation
        let offset = 5.0
        let endOfLine = circleCenter.y + circleRadius + offset - rect.maxY
        let lineWidth = min(rect.height, rect.width) * 0.05
        path.addRect(CGRect(x: circleCenter.x - lineWidth / 2, y: rect.maxY - offset, width: lineWidth, height: endOfLine))
//        path.addLine(to: endOfLine)
        
        // Draw outer circle
        path.addArc(center: circleCenter, radius: circleRadius, startAngle: .degrees(90), endAngle: .degrees(90 - 360), clockwise: false)

        // Move to starting point for inner circle to be drawn
        path.move(to: CGPoint(x: circleCenter.x + circleRadius / 2, y: circleCenter.y))
        path.addArc(center: circleCenter, radius: circleRadius / 2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        
        return path
    }
}

struct LoadingLeaf: View, ThemedView {
    @EnvironmentObject var themeManager: ThemeManager
    
    @State private var progress: CGFloat = 0.0
    @State private var opacity: CGFloat = 0
    let duration: Double = 2.0
    
    var body: some View {
        VStack(alignment: .center){
            LeafColor()
                .trim(from: 0, to: progress)
                .stroke(theme.primaryColor)
                .background(
                    LeafColor().opacity(opacity)
                )
                .shadow(radius: 5)
                .frame(maxHeight: 400)
                .padding(.top)
                .onAppear {
                    withAnimation(.linear(duration: duration)) {
                        progress = 1.0
                    }
                }.onChange(of: progress) { newValue in
                    withAnimation(.easeIn(duration: 1)) {
                        opacity = newValue / 5
                    }
                }
        }
    }
}

#Preview {
    LoadingLeaf()
        .environmentObject(ThemeManager())
//        .frame(width: 200, height: 300)
}
