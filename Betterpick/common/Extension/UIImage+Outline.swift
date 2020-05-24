//
//  UIImage+Outline.swift
//  Betterpick
//
//  Created by David Bielik on 10/05/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

// FIXME: Remove this class if outlined is not needed
// https://stackoverflow.com/questions/47900243/how-to-add-colored-border-to-uiimage-in-swift
extension UIImage {
    /**
    Returns the stroked version of the fransparent image with the given stroke color and the thickness.

    - Parameters:
        - color: The color to use for the outline.
        - lineWidth: the thickness of the border. Default to `1`

    - Returns: the stroked version of the image, or self if something was wrong
    */
    func outlined(color: UIColor, lineWidth: CGFloat = 1) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)

        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        self.draw(in: rect, blendMode: .normal, alpha: 1.0)
        print(scale, rect, CGSize(width: size.width*scale, height: size.height*scale))
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(color.cgColor)
        context?.setLineWidth(lineWidth)
        context?.stroke(rect)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}
