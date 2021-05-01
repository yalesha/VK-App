//
//  FriendsCollectionViewCell.swift
//  VK_App_new
//
//  Created by Алексей Якуба on 11.03.2021.
//

import UIKit

class FriendsCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var friendsImageView: UIImageView!
  @IBOutlet weak var likeControl: LikeControl!
  
  override func awakeFromNib() {
    friendsImageView.contentMode = .scaleAspectFill
  }
  
  lazy var tapGestureRecognizer: UITapGestureRecognizer = {
    let recognizer = UITapGestureRecognizer(target: self,
                                            action: #selector(onTap(_:)))
    recognizer.numberOfTapsRequired = 1
    recognizer.numberOfTouchesRequired = 1
    return recognizer
  }()
  
  @objc func onTap(_ sender: UIImageView) {
    ImageTapAnimations.animateImageTap(imageView: friendsImageView)
    
    
    
  }

}
