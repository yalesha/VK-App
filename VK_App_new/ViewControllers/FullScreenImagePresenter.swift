//
//  FullScreenImagePresenter.swift
//  VK_App_new
//
//  Created by Алексей Якуба on 11.03.2021.
//

import UIKit

class FullScreenImagePresenter: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
  
  @IBOutlet weak var fullScreenCollectionView: UICollectionView!
  private let reuseIdentifier = "fullScreenCollectionViewCellIdentifier"
  var friendToDisplay: User?
  var imagesToDisplay: [String] = []
  var indexPathToScrollTo = IndexPath(row:0, section:0)
  var newCellIndexPath = IndexPath(row: 0, section: 0)
  var oldCellIndexPath = IndexPath(row: 0, section: 0)
  var scrollChangedDirection: Bool = false
  
  //MARK: Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    fullScreenCollectionView.dataSource = self
    fullScreenCollectionView.delegate = self
    
    setupCollectionViewAppearance()
    
    if let friend = friendToDisplay {
      imagesToDisplay = Content.getUserImages(userName: friend.lastName)
      fullScreenCollectionView.scrollToItem(at: indexPathToScrollTo, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
      
      let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipedToDismiss))
      
      swipeDown.delegate = self
      
      view.addGestureRecognizer(swipeDown)
    }
  }
  
  // MARK: UICollectionViewDataSource
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return imagesToDisplay.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let image = UIImage(named: imagesToDisplay[indexPath.row])
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FullScreenCollectionViewCell    // Configure the cell
    cell.friendsImageView.image = image
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
  
     newCellIndexPath = indexPath
    
    var scroll = ScrollDirection.right
  
    if (newCellIndexPath.row - oldCellIndexPath.row > 0) {
      scroll = ScrollDirection.right
    } else if (newCellIndexPath.row - oldCellIndexPath.row < 0) {
       scroll = ScrollDirection.left
    }
    
      if (oldCellIndexPath.row == imagesToDisplay.count - 1) {
      scroll = ScrollDirection.left
    }
    

    cell.alpha = 0
    cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
    UIView.animate(withDuration: 1) {
      cell.alpha = 1
      cell.transform = CGAffineTransform(scaleX: 1, y: 1)
      
      
    }
    
    switch scroll {
      
    case .right:
      
        if (indexPath.row > 0) {
        let oldIndexPath = IndexPath(row: indexPath.row - 1, section: 0)
          if let oldCell = collectionView.cellForItem(at: oldIndexPath) {
          UIView.animate(withDuration: 0.8) {
            oldCell.alpha = 0.5
            oldCell.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            }
          }
        }
        
    case .left:
       
      if (indexPath.row < imagesToDisplay.count - 1) {
      let oldIndexPath = IndexPath(row: indexPath.row + 1, section: 0)
      if let oldCell = collectionView.cellForItem(at: oldIndexPath) {
        UIView.animate(withDuration: 0.8) {
          oldCell.alpha = 0.5
          oldCell.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }
      }
     }
    }
     oldCellIndexPath = indexPath
  }

  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    if let cell = collectionView.cellForItem(at: indexPath) {
    
    UIView.animate(withDuration: 0.5,
                   animations: {
                    cell.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                    cell.alpha = 0
    },
                   completion: { _ in
                    self.dismiss(animated: true, completion: nil)
    })
    
    }
  }
  //MARK: CollectionView appearance
  private func setupCollectionViewAppearance() {
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    let flowLayout = UICollectionViewFlowLayout()
    
    flowLayout.scrollDirection = .horizontal
   
    flowLayout.minimumInteritemSpacing = 0
    flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    if (width < height) {
       flowLayout.minimumLineSpacing = 0
      flowLayout.itemSize = CGSize(width: width, height: width)
      
    } else {
       flowLayout.minimumLineSpacing = width/2
      flowLayout.itemSize = CGSize(width: height, height: height)
    }
    
    fullScreenCollectionView.collectionViewLayout = flowLayout
    fullScreenCollectionView.backgroundColor = .black
    fullScreenCollectionView.isPagingEnabled = true
  }
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    if traitCollection.horizontalSizeClass == .compact {
      setupCollectionViewAppearance()
    } else {
     setupCollectionViewAppearance()
    }
  }
  
  @objc func swipedToDismiss() {
    if let cell = fullScreenCollectionView.cellForItem(at: newCellIndexPath) {
      print("swiped down to dismiss")
      UIView.animate(withDuration: 0.5,
                     animations: {
                      cell.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                      cell.alpha = 0
      },
                     completion: { _ in
                      self.dismiss(animated: true, completion: nil)
      })
      
    }
  }
  
}


extension FullScreenImagePresenter {
  enum ScrollDirection {
    case right
    case left
  }
}

extension FullScreenImagePresenter: UIGestureRecognizerDelegate {
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
}
