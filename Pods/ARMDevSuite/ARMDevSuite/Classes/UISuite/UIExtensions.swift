//
//  UIExtensions.swift
//  ARMDevSuite
//
//  Created by Ajay Merchia on 2/7/19.
//

import Foundation
import UIKit

public extension UIImage {
    func resizeTo(_ sizeChange:CGSize) -> UIImage {
        
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        self.draw(in: CGRect(origin: .zero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage!
    }
}

public extension UIButton {
    
    /// Sets the background color of the button for a UIControl.State
    ///
    /// - Parameters:
    ///   - color: background color
    ///   - forState: state for which the color should show.s
    public func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(colorImage, for: forState)
    }
}

public extension UIColor {
    
    /// Gets a random color
    ///
    /// - Returns: random color
    public static func randomColor() -> UIColor {
        let hue : CGFloat = CGFloat(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
        let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from white
        let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from black
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
    
    /// Creates a color from a UInt as a hexvalue with the given alpha.
    ///
    /// - Parameters:
    ///   - rgbValue: color given as hexvalue
    ///   - alpha: alpha of the new color
    /// - Returns: new color
    public class func colorWithRGB(rgbValue : UInt, alpha : CGFloat = 1.0) -> UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255
        let green = CGFloat((rgbValue & 0xFF00) >> 8) / 255
        let blue = CGFloat(rgbValue & 0xFF) / 255
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    
    /// Modulates the current UIColor and returns a new instance with modified values.
    ///
    /// - Parameters:
    ///   - hue: additional hue to provide
    ///   - additionalSaturation: additional saturation to provide
    ///   - additionalBrightness: additional brightness to provide
    /// - Returns: new Color
    public func modified(withAdditionalHue hue: CGFloat, additionalSaturation: CGFloat, additionalBrightness: CGFloat) -> UIColor {
        var currentHue: CGFloat = 0.0
        var currentSaturation: CGFloat = 0.0
        var currentBrigthness: CGFloat = 0.0
        var currentAlpha: CGFloat = 0.0
        
        if self.getHue(&currentHue, saturation: &currentSaturation, brightness: &currentBrigthness, alpha: &currentAlpha){
            return UIColor(hue: currentHue + hue,
                           saturation: currentSaturation + additionalSaturation,
                           brightness: currentBrigthness + additionalBrightness,
                           alpha: currentAlpha)
        } else {
            return self
        }
    }
}

/// A Simple class to assist with UI Color theme
public class rgba: UIColor {
    
    /// Creates a new UIColor using rgba values on a scale of 0 to 255
    ///
    /// - Parameters:
    ///   - r: red on a scale from 0 to 255
    ///   - g: green on a scale from 0 to 255
    ///   - b: blue on a scale from 0 to 255
    ///   - a: alpha coeffiecient from 0 to 1
    /// - Returns: UIColor with the given rgba attributes
    public convenience init(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) {
        self.init(red: r/255.00, green: g/255.00, blue: b/255.00, alpha: a)
    }
}
public class rgb: UIColor {
    
    /// Creates a new UIColor using rgb values on a scale of 0 to 255
    ///
    /// - Parameters:
    ///   - r: red on a scale from 0 to 255
    ///   - g: green on a scale from 0 to 255
    ///   - b: blue on a scale from 0 to 255
    public convenience init(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) {
        self.init(red: r/255.00, green: g/255.00, blue: b/255.00, alpha: 1)
    }
}


public extension NSMutableAttributedString {
    
    /// Sets the color of a substring within an NSMutableAttributedString
    ///
    /// - Parameters:
    ///   - color: color to set the substring to
    ///   - stringValue: substring to change
    public func setColor(color: UIColor, forText stringValue: String) {
        let range: NSRange = self.mutableString.range(of: stringValue, options: .caseInsensitive)
        self.addAttribute(.foregroundColor, value: color, range: range)
    }
    
}

public extension UILabel {
    
    /// Sets a UILabel's text and colorizes a part of it.
    ///
    /// - Parameters:
    ///   - text: new text for the label
    ///   - color: color for the substring
    ///   - substring: substring to colorize
    public func setText(to text: String, with color: UIColor, for substring: String) {
        let attString = NSMutableAttributedString(string: text)
        attString.setColor(color: color, forText: substring)
        
        self.attributedText = attString
    }
}

public extension UIView {
    
    /// Shakes the UIView given the parameters
    ///
    /// - Parameters:
    ///   - count: number of movements
    ///   - duration: duration of the shaking animation
    ///   - translation: how much the uiview should move when shaking
    func shake(count : Float = 1, duration : TimeInterval = 0.125, withTranslation translation : Float = 7.5) {
        
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = count
        animation.duration = duration/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: CGFloat(-translation), y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: CGFloat(translation), y: self.center.y))
        layer.add(animation, forKey: "shake")
        
        
    }
}

extension CGFloat {
    static let padding: CGFloat = 20
    static let marginalPadding: CGFloat = 5
}
