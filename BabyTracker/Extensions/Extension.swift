//
//  Extension.swift
//  BabyTracker
//
//  Created by Nikita Chekmarev on 23.06.2023.
//


import UIKit

extension UIColor {
    static func rgb (red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIImage {
    
    public static func pixel(ofColor color: UIColor) -> UIImage {
        let pixel = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)

        UIGraphicsBeginImageContext(pixel.size)
        defer { UIGraphicsEndImageContext() }

        guard let context = UIGraphicsGetCurrentContext() else { return UIImage() }

        context.setFillColor(color.cgColor)
        context.fill(pixel)

        return UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
    }
}

extension UIButton {
    func setBackgroundColor(_ backgroundColor: UIColor?, for state: UIControl.State) {
        self.setBackgroundImage(.pixel(ofColor: backgroundColor!), for: state)
    }
}

class UICustomView: UIView {
    var isActive: ElementActivity = .inactive
    
    var color = R.color.wildSand()
    var lineWidth: CGFloat = 3
    var dashPattern: [CGFloat] = [2, 4]
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
                
        drawBorder()
    }
    
    func drawBorder() {
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: 10)
        
        UIColor.white.setFill()
        path.fill()
        path.lineWidth = lineWidth
        
        switch isActive {
        case .active:
            R.color.heliotrope()?.setStroke()
            
            path.setLineDash(dashPattern, count: 2, phase: 0)
        case .inactive:
            color?.setStroke()
        }
        path.stroke()
    }
}
