//
//  NewsTableViewCell.swift
//  VK_App_new
//
//  Created by Алексей Якуба on 11.03.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
  
  @IBOutlet weak var newsLabel: UILabel!
  @IBOutlet weak var newsCollectionView: UICollectionView!
  @IBOutlet weak var likes: LikeControl!
  @IBOutlet weak var comments: CommentControl!
  @IBOutlet weak var shares: ShareControl!
  @IBOutlet weak var views: ViewsControl!
  
  var newsPicturesArray: [String] = []

  //MARK: Lifecycle
  override func awakeFromNib() {
        super.awakeFromNib()
        newsCollectionView.dataSource = self
        newsCollectionView.delegate = self
        newsCollectionView.register(UINib.init(nibName: "NewsAdvancedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NewsAdvancedCollectionViewReusableCell")
        setCustomFlowLayout()
    }
  
  //Mark: Setup collectionView
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 7
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
   let cell = newsCollectionView.dequeueReusableCell(withReuseIdentifier: "NewsAdvancedCollectionViewReusableCell", for: indexPath) as! NewsAdvancedCollectionViewCell
    if (indexPath.row < 7) {
    cell.newsCollectionImageView.image = UIImage(named: newsPicturesArray[indexPath.row])
    }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let reverseAspectRatio = 0.5625
    let reverseAspectRatioForTopRow = 0.667
    let margins: CGFloat = 10
    let effectiveHeight = newsCollectionView.visibleSize.height - margins
    let cellCount = indexPath.row + 1
    var picHeight = CGFloat()
    var picWidth: CGFloat { return picHeight/CGFloat(reverseAspectRatio) }
    var cellSize = CGSize(width: 44, height: 44)
  
    if (cellCount < 5) {
      picHeight = effectiveHeight * 0.15625
      let picWidthForTopRow = picHeight/CGFloat(reverseAspectRatioForTopRow)
      cellSize = CGSize(width: picWidthForTopRow, height: picHeight)
    } else if (cellCount > 4 && cellCount < 7) {
      picHeight = effectiveHeight * 0.28125
      cellSize = CGSize(width: picWidth, height: picHeight)
    } else {
      picHeight = effectiveHeight * 0.5625
      cellSize = CGSize(width: picWidth, height: picHeight)
    }
    return cellSize
  }
  
  func setCustomFlowLayout() {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .vertical
    flowLayout.minimumLineSpacing = 5
    flowLayout.minimumInteritemSpacing = 5
    newsCollectionView.collectionViewLayout = flowLayout
  }
}
