//
//  ViewsControl.swift
//  VK_App_new
//
//  Created by Алексей Якуба on 11.03.2021.
//

import Foundation
import UIKit

class ViewsControl: UIControl {
  private var stackView: UIStackView!
  private var viewsIcon = UIImage(named: "Canvas 1.png")
  private var viewsIconView = UIImageView()
  private let viewsLabel = UILabel()
  private var viewsCount: Int = 0
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.setupView()
  }
  
  private func setupView() {
    viewsIconView.image = viewsIcon
    viewsIconView.frame = CGRect(x: 0, y: 0, width: 22, height: 22)
    viewsLabel.text = "\(viewsCount)"
    viewsLabel.textColor = UIColor.darkGray
    setupConstraints()
    
    
    stackView = UIStackView(arrangedSubviews: [viewsIconView, viewsLabel])
    
    self.addSubview(stackView)
    stackView.distribution = .fillEqually
    addGestureRecognizer(tapGestureRecognizer)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    stackView.frame = bounds
  }
  
  func setupConstraints() {
    viewsLabel.heightAnchor.constraint(equalTo: viewsIconView.heightAnchor, multiplier: 1)
  }
  
  func incrementViewsCount() {
    viewsCount += 1
    updateViewsCount(comments: viewsCount)
  }
  
  func decrementViewsCount() {
    viewsCount -= 1
    updateViewsCount(comments: viewsCount)
  }
  
  func updateViewsCount(comments: Int) {
    viewsCount = comments
    viewsLabel.text = "\(viewsCount)"
  }
  
  lazy var tapGestureRecognizer: UITapGestureRecognizer = {
    let recognizer = UITapGestureRecognizer(target: self,
                                            action: #selector(onTap(_:)))
    recognizer.numberOfTapsRequired = 1
    recognizer.numberOfTouchesRequired = 1
    return recognizer
  }()
  
  @objc func onTap(_ sender: UIStackView) {
    incrementViewsCount()
  }
}
