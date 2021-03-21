//
//  CircularImageView.swift
//  VK_App_new
//
//  Created by Алексей Якуба on 11.03.2021.
//

import Foundation

import UIKit

@IBDesignable class CircleImageView: UIImageView {
  
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
  }
  
  func setCornerRadius(value: CGFloat) {
    layer.cornerRadius = value
  }
}
