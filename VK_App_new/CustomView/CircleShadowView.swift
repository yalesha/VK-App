//
//  CircularShadowView.swift
//  VK_App_new
//
//  Created by Алексей Якуба on 11.03.2021.
//

import Foundation
import UIKit

@IBDesignable class CircleShadowView: UIImageView {
 
  @IBInspectable var shadowColor: UIColor = .black
  @IBInspectable var shadowOpacity: Float = 0.5
  @IBInspectable var shadowRadius: CGFloat = 8
  @IBInspectable var shadowOffset: CGSize = .zero
  
  var cornerRadius: CGFloat {
    return frame.width/2
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    sharedInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    sharedInit()
  }
  
  override func prepareForInterfaceBuilder() {
    sharedInit()
  }
  
  func sharedInit() {
    setCornerRadius(value: cornerRadius)
    setShadow()
  }
  
  func setCornerRadius(value: CGFloat) {
    layer.cornerRadius = value
  }
  
  func setShadow() {
    layer.shadowColor = shadowColor.cgColor
    layer.shadowOpacity = shadowOpacity
    layer.shadowRadius = shadowRadius
    layer.shadowOffset = shadowOffset
    layer.masksToBounds = false
  }
}
