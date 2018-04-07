//
//  Loading.swift
//  synchronoss
//
//  Created by Lucas Correa on 05/04/2018.
//  Copyright © 2018 SiriusCode. All rights reserved.
//

import Foundation
import UIKit

class Loading {
    
    class func show(view: UIView) {
        if view.viewWithTag(9999) != nil {
            let backgroundView: UIView = view.viewWithTag(9999)!
            backgroundView.removeFromSuperview()
        }
        
        let backgroundView = UIView(frame: view.bounds)
        backgroundView.tag = 9999
        backgroundView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let logoImageView = UIImageView(image: UIImage(named: "logo"))
      
        logoImageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        logoImageView.center = backgroundView.center
        logoImageView.contentMode = UIViewContentMode.scaleAspectFit
        
        let animation = CABasicAnimation(keyPath: "transform")
        logoImageView.layer.zPosition = 100
        
        let transform = CATransform3DMakeScale(1.05, 1.05, 1.05)
        
        animation.toValue = NSValue(caTransform3D:transform)
        animation.duration = 0.5
        animation.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        
        logoImageView.layer.add(animation, forKey: "rotateAnimation")
        backgroundView.addSubview(logoImageView)
        backgroundView.alpha = 0
        view.addSubview(backgroundView)
        
        UIView.animate(withDuration: 0.25, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
            backgroundView.alpha = 1
            }, completion: { (_) -> Void in
        })
        
    }
    
    class func close(view: UIView) {
        if view.viewWithTag(9999) != nil {
            let backgroundView: UIView = view.viewWithTag(9999)!
            
            delay(0.6) {
                UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: { () -> Void in
                    backgroundView.alpha = 0
                }, completion: { (_) -> Void in
                    backgroundView.removeFromSuperview()
                })
            }
        }
    }
}
