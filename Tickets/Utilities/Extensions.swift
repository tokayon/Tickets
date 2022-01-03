//
//  Extensions.swift
//  Tickets
//
//  Created by Serge Sinkevych on 1/2/22.
//

import SwiftUI

struct StrokeButtonModifier: ViewModifier {
    
    var size: CGFloat
    var width: CGFloat
    var height: CGFloat
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: size, weight: .semibold, design: .rounded))
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .frame(minWidth: width, minHeight: height)
            .foregroundColor(color)
            .background(
                Capsule().stroke(color, lineWidth: 2)
            )
    }
}

extension View {
    
    func strokeButtonStyle(size: CGFloat, width: CGFloat, height: CGFloat, color: Color) -> some View {
        modifier ( StrokeButtonModifier(size: size, width: width, height: height, color: color) )
    }
    
    func gradient(top: Color, bottom: Color) -> LinearGradient {
        return LinearGradient(gradient: Gradient(colors:[top, bottom]), startPoint: .top, endPoint: .bottom)
    }
    
    func gradient(topLeft: Color, bottomRight: Color) -> LinearGradient {
        return LinearGradient(gradient: Gradient(colors:[topLeft, bottomRight]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    func gradient(left: Color, right: Color) -> LinearGradient {
        return LinearGradient(gradient: Gradient(colors:[left, right]), startPoint: .leading, endPoint: .trailing)
    }
}

extension Date {
    var regular: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        return dateFormatter.string(from: self)
    }
    
    var iso8601: String {
        return Formatter.iso8601withFractionalSeconds.string(from: self)
    }
}

extension String {
    var iso8601: Date {
        return Formatter.iso8601withFractionalSeconds.date(from: self) ?? Date()
    }
}

extension ISO8601DateFormatter {
    convenience init(_ formatOptions: Options) {
        self.init()
        self.formatOptions = formatOptions
    }
}

extension Formatter {
    static let iso8601withFractionalSeconds = ISO8601DateFormatter([.withInternetDateTime, .withFractionalSeconds])
}

extension Color {
    static func gray(_ value: Double) -> Color {
        return Color.init(red: value/255, green: value/255, blue: value/255)
    }
}

extension NSColor {
    static func gray(_ value: CGFloat) -> NSColor {
        return NSColor.init(red: value/255, green: value/255, blue: value/255, alpha: 1)
    }
}

//extension NSTableView {
//    open override func viewDidMoveToWindow() {
//        super.viewDidMoveToWindow()
//        backgroundColor = NSColor.clear
//        enclosingScrollView!.drawsBackground = false
//    }
//}
