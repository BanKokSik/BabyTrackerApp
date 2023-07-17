//
//  BorderView.swift
//  BabyTracker
//
//  Created by Nikita Chekmarev on 08.07.2023.
//

import UIKit

class BorderView: UIView {

   
    var isActive = Bool()
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: 10)
        
        UIColor.white.setFill()
        path.fill()
        path.lineWidth = 3
        
        switch isActive {
        case true:
            UIColor.rgb(red: 207, green: 105, blue: 255).setStroke()
            let dashPattern : [CGFloat] = [2, 2]
            path.setLineDash(dashPattern, count: 2, phase: 0)
            
        case false:
            UIColor.rgb(red: 245, green: 245, blue: 245).setStroke()
        }
        path.stroke()
    }
    
}
