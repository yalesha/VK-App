//
//  LikeControl.swift
//  VK_App_new
//
//  Created by Алексей Якуба on 11.03.2021.
//

import Foundation
import UIKit

class LikeControl: UIControl {
  private var stackView: UIStackView!
  private var likeButton = HeartButton()
  private let likesLabel = UILabel()
  private var likesCount: Int = 0
  private var liked: Bool = false

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.setupView()
  }

  private func setupView() {
    likeButton.isUserInteractionEnabled = false
    likesLabel.text = "\(likesCount)"
    likesLabel.textColor = UIColor.darkGray
    setupConstraints()
   

    
    stackView = UIStackView(arrangedSubviews: [likeButton, likesLabel])
    self.addSubview(stackView)
    stackView.distribution = .fillEqually
    addGestureRecognizer(tapGestureRecognizer)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    stackView.frame = bounds
  }
  
  func setupConstraints() {
    likesLabel.heightAnchor.constraint(equalTo: likeButton.heightAnchor, multiplier: 1)
  }
  
  func incrementLikesCount() {
    likesCount += 1
    updateLikesCount(likes: likesCount)
  }

  func decrementLikesCount() {
    likesCount -= 1
    updateLikesCount(likes: likesCount)
  }
  
  func updateLikesCount(likes: Int) {
    likesCount = likes
    likesLabel.text = "\(likesCount)"
  }
  
  func like() {
    if !liked {
    likeButton.liked = true
    likeButton.setNeedsDisplay()
    incrementLikesCount()
    liked = true
    } else {
      likeButton.liked = false
      likeButton.setNeedsDisplay()
      decrementLikesCount()
      liked = false
    }
  }
  
  lazy var tapGestureRecognizer: UITapGestureRecognizer = {
    let recognizer = UITapGestureRecognizer(target: self,
                                            action: #selector(onTap(_:)))
    recognizer.numberOfTapsRequired = 1
    recognizer.numberOfTouchesRequired = 1
    return recognizer
  }()
  
  @objc func onTap(_ sender: HeartButton) {
    like()
    animateLikeButton()
  }
  
  
  func animateLikeButton() {
    let animation = CASpringAnimation(keyPath: "transform.scale")
    animation.fromValue = 0
    animation.toValue = 1
    animation.stiffness = 200
    animation.mass = 1
    animation.duration = 1
    animation.beginTime = CACurrentMediaTime()
    animation.fillMode = CAMediaTimingFillMode.backwards
    
    self.likeButton.layer.add(animation, forKey: nil)
  }

}
