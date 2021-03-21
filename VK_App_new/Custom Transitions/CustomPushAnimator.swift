//
//  CustomPushAnimator.swift
//  VK_App_new
//
//  Created by Алексей Якуба on 11.03.2021.
//

import UIKit

 class CustomPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.8
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
    guard let source = transitionContext.viewController(forKey: .from) else { return }
    guard let destination = transitionContext.viewController(forKey: .to) else { return }
    
    let width = source.view.frame.width
    let height = source.view.frame.height
    
    let initialTranslation = CGAffineTransform(translationX: width/2 + height/2, y: -width/2)
    let initialRotation = CGAffineTransform(rotationAngle: -90 * .pi/180)
    
    transitionContext.containerView.backgroundColor = .white
    
    transitionContext.containerView.addSubview(destination.view)
    destination.view.frame = source.view.frame
    destination.view.transform = initialRotation.concatenating(initialTranslation)

    UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext),
                            delay: 0,
                            options: .calculationModePaced,
                            animations: {
              UIView.addKeyframe(withRelativeStartTime: 0,
                      relativeDuration: 0.5,
                      animations: {
                      let translation = CGAffineTransform(translationX: -100 , y: 0)
                      let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
                      source.view.transform = scale.concatenating(translation)
                                                  
    })
              UIView.addKeyframe(withRelativeStartTime: 0,
                       relativeDuration: 0.8,
                       animations: {
                        let translation = CGAffineTransform(translationX: 0 , y: 0)
                        let rotation = CGAffineTransform(rotationAngle: 0)
                        destination.view.transform = rotation.concatenating(translation)

  })
    }) { finished in
      if finished && !transitionContext.transitionWasCancelled {
         source.view.transform = .identity
      }
      if transitionContext.transitionWasCancelled {
        destination.view.transform = .identity
        source.view.transform = .identity
      }
      transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
    }
  }
}
