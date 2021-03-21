//
//  FriendsListCell.swift
//  VK_App_new
//
//  Created by Алексей Якуба on 11.03.2021.
//

import UIKit

class FriendsListCell: UITableViewCell {
  
  @IBOutlet weak var friendsAvatar: CircleImageView!
  @IBOutlet weak var friendsName: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}


