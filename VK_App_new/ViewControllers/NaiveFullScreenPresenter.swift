//
//  NaiveFullScreenPresenter.swift
//  VK_App_new
//
//  Created by Алексей Якуба on 11.03.2021.
//

import UIKit

class NaiveFullScreenPresenter: UIViewController {
  
  @IBOutlet weak var fullScreenImageView: UIImageView!
    
  var friendToDisplay: Friends?
  var imagesToDisplay: [String] = []
  var index: Int = 0
  var currentImageIndex: Int = 0
  let slidingImageView = UIImageView()
  
  override func viewDidLoad() {
    fullScreenImageView.contentMode = .scaleAspectFit
    fullScreenImageView.backgroundColor = .black
    slidingImageView.frame = UIScreen.main.bounds
    slidingImageView.image = UIImage(named: imagesToDisplay[index])
    slidingImageView.contentMode = .scaleAspectFit
    view.addSubview(slidingImageView)
    view.backgroundColor = .black
    
    //constraints
    slidingImageView.translatesAutoresizingMaskIntoConstraints = false
    let horizontalConstraint = slidingImageView.topAnchor.constraint(equalTo: fullScreenImageView.topAnchor)
    let verticalConstraint = slidingImageView.bottomAnchor.constraint(equalTo: fullScreenImageView.bottomAnchor)
    let widthConstraint = slidingImageView.leadingAnchor.constraint(equalTo: fullScreenImageView.leadingAnchor)
    let heightConstraint = slidingImageView.trailingAnchor.constraint(equalTo: fullScreenImageView.trailingAnchor)
    view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    
    let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(onSwipe))
    swipeRight.direction = UISwipeGestureRecognizer.Direction.right
    self.view.addGestureRecognizer(swipeRight)
    
    let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(onSwipe))
    swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
    self.view.addGestureRecognizer(swipeLeft)
    
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTap))
    self.view.addGestureRecognizer(tapGestureRecognizer)
  }
  
 @objc func onSwipe(gesture: UIGestureRecognizer) {
    
    if let swipeGesture = gesture as? UISwipeGestureRecognizer {
      switch swipeGesture.direction {
        
      case UISwipeGestureRecognizer.Direction.left:
        //last image
        if currentImageIndex == imagesToDisplay.count - 1 {
          currentImageIndex = 0
        }else{
          currentImageIndex += 1
        }
        fullScreenImageView.image = UIImage(named: imagesToDisplay[currentImageIndex])
        animateSwipeLeft()
        
      case UISwipeGestureRecognizer.Direction.right:
        //first image
        if currentImageIndex == 0 {
          currentImageIndex = imagesToDisplay.count - 1
        }else{
          currentImageIndex -= 1
        }
        fullScreenImageView.image = UIImage(named: imagesToDisplay[currentImageIndex])
        animateSwipeRight()
        
      default:
        break
      }
    }
  }
  
  private func animateSwipeLeft() {
    UIView.animateKeyframes(withDuration: 1,
                            delay: 0,
                            options: .calculationModeCubic,
                            animations: {
                              UIView.addKeyframe(withRelativeStartTime: 0,
                                                 relativeDuration: 0.33,
                                                 animations: {

                                                  self.slidingImageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                                                  
                                                  let opacityAnimation = CABasicAnimation(keyPath: "opacity")
                                                  opacityAnimation.fromValue = 1
                                                  opacityAnimation.toValue = 0
                                                  opacityAnimation.duration = 1
                                                  self.slidingImageView.layer.add(opacityAnimation, forKey: nil)
                                                  
                              })

                              UIView.addKeyframe(withRelativeStartTime: 0.33,
                                                 relativeDuration: 0.66,
                                                 animations: {

                                                  self.slidingImageView.alpha = 0
                                                  
                                                  let animation = CABasicAnimation(keyPath: "position.x")
                                                  animation.fromValue = self.fullScreenImageView.layer.bounds.origin.x + 600
                                                  animation.toValue = self.fullScreenImageView.layer.bounds.origin.x
                                                  animation.duration = 1
                                                  self.fullScreenImageView.layer.add(animation, forKey: nil)

                              })
                              
                              UIView.addKeyframe(withRelativeStartTime: 0.99,
                                                 relativeDuration: 0.01,
                                                 animations: {

                              })
                              
    }, completion: {[weak self] finished in
      self!.slidingImageView.image = UIImage(named: self!.imagesToDisplay[self!.currentImageIndex])
      self!.slidingImageView.transform = .identity})
  }
  
  private func animateSwipeRight() {
    UIView.animateKeyframes(withDuration: 1,
                            delay: 0,
                            options: .calculationModeCubic,
                            animations: {
                              UIView.addKeyframe(withRelativeStartTime: 0,
                                                 relativeDuration: 0.33,
                                                 animations: {
                                                  
                                                  let animation = CABasicAnimation(keyPath: "position.x")
                                                  animation.fromValue = self.slidingImageView.layer.bounds.origin.x
                                                  animation.toValue = self.slidingImageView.layer.bounds.origin.x + 600
                                                  animation.duration = 1
                                                  self.slidingImageView.layer.add(animation, forKey: nil)
                                                  
                                                  let opacityAnimation = CABasicAnimation(keyPath: "opacity")
                                                  opacityAnimation.fromValue = 0
                                                  opacityAnimation.toValue = 1
                                                  opacityAnimation.duration = 1
                                                  self.slidingImageView.layer.add(opacityAnimation, forKey: nil)
             
                              })
                              
                              UIView.addKeyframe(withRelativeStartTime: 0.33,
                                                 relativeDuration: 0.66,
                                                 animations: {
                                                  let animation = CABasicAnimation(keyPath: "transform.scale")
                                                  animation.fromValue = 0.1
                                                  animation.toValue = 1
                                                  animation.duration = 1
                                                  self.fullScreenImageView.layer.add(animation, forKey: nil)
                                                  
                              })
                              
                              UIView.addKeyframe(withRelativeStartTime: 0.99,
                                                 relativeDuration: 0.01,
                                                 animations: {
                                                  
                              })
                              
    }, completion: {[weak self] finished in
      var counter: Int {
        if self!.currentImageIndex == self!.imagesToDisplay.count - 1 {return 0}
        else {return self!.currentImageIndex + 1}
      }
     self!.slidingImageView.image = UIImage(named: self!.imagesToDisplay[counter])
      self!.slidingImageView.transform = .identity})
  }
  
  @objc func onTap() {
    self.dismiss(animated: true, completion: nil)
  }
}
