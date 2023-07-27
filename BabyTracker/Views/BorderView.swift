//
//  BorderView.swift
//  BabyTracker
//
//  Created by Мявкo on 24.07.23.
//

import UIKit

enum ElementActivity {
    case active
    case inactive
    case error
}

class BorderView: UIView {
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
        case .error:
            R.color.bittersweet()?.setStroke()
            path.setLineDash(dashPattern, count: 2, phase: 0)
        }
        path.stroke()
    }
}
