//
//  UIViewEXT.swift
//  breakpoint
//
//  Created by Ali Zuberi  on 2018-12-08.
//  Copyright © 2018 Ali Zuberi . All rights reserved.
//

import UIKit

extension UIView {
    func bindToKeyboard() {
            NotificationCenter.default.addObserver(self, selector: #selector(UIView.keyboardWillChange(_:)), name:
                UIApplication.keyboardWillChangeFrameNotification
                , object: nil)

    }
    
    
    

 @objc func keyboardWillChange(_ notification: NSNotification) {
    
    let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
    let curve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
    let beginningFrame = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
    let endFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
    let deltaY = endFrame.origin.y - beginningFrame.origin.y
    

    
    UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIView.KeyframeAnimationOptions(rawValue:curve), animations:{
        self.frame.origin.y += deltaY
    }
        , completion: nil)
  
}
    

    

}

