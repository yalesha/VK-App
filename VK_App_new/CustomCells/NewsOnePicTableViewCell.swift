//
//  NewsOnePicTableViewCell.swift
//  VK_App_new
//
//  Created by Алексей Якуба on 11.03.2021.
//

import UIKit

class NewsOnePicTableViewCell: UITableViewCell {
    
  @IBOutlet weak var newsLabel: UILabel!
  @IBOutlet weak var newsOnePicImageView: UIImageView!
  @IBOutlet weak var likes: LikeControl!
  @IBOutlet weak var comments: CommentControl!
  @IBOutlet weak var shares: ShareControl!
  @IBOutlet weak var views: ViewsControl!
  
  //MARK: Lifecycle
  override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
