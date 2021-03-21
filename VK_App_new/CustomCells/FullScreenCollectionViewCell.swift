//
//  FullScreenCollectionViewCell.swift
//  VK_App_new
//
//  Created by Алексей Якуба on 11.03.2021.
//

import UIKit

class FullScreenCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var friendsImageView: UIImageView!
  
  override func awakeFromNib() {
    friendsImageView.contentMode = .scaleAspectFit

  }
  
}
