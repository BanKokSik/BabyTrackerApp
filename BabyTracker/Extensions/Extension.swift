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

extension NSMutableAttributedString{
    public func setAsLink(textToFind:String, linkURL:String) -> Bool {
        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            self.addAttribute(.link, value: linkURL, range: foundRange)
           
            return true
        }
        return false
    }
}

extension UITextView {
    
    func textWithSpaceBetweenLines(text: NSMutableAttributedString, space: Double) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = CGFloat(space)
     
        text.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: text.length))
        return text
    }
    
    func textWithSpaceBetweenLines(text: String, space: Double) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = space
 
        let attributedText = NSAttributedString(string: text, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return attributedText
    }
}

