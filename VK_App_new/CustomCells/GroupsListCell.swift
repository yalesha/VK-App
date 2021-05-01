//
//  GroupsListCell.swift
//  VK_App_new
//
//  Created by Алексей Якуба on 11.03.2021.
//

import UIKit

class GroupsListCell: UITableViewCell {

  @IBOutlet weak var groupsAvatar: CircleImageView!
  @IBOutlet weak var groupsName: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    public func configureGroup(with group: Group) {
        groupsName.text = "\(group.name)"
        groupsAvatar.kf.setImage(with: group.pictureUrl)
    }
}
