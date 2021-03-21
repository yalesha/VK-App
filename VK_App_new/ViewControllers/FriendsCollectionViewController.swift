//
//  FriendsCollectionViewController.swift
//  VK_App_new
//
//  Created by Алексей Якуба on 11.03.2021.
//

import UIKit

class FriendsCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
  
  @IBOutlet var friendsImagesCollectionView: UICollectionView!
  
  private let reuseIdentifier = "friendsImageReusableCollectionCell"
  var friendToDisplay: Friends?
//  var imagesToDisplay: [String] = []
  var selectedIndexPath = IndexPath(row: 0, section: 0)
  let presentTransition = CustomPresentModalAnimator()
  let dismissTransition = CustomDismissModalAnimator()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
//      if let friend = friendToDisplay {
//        imagesToDisplay = Content.getUserImages(userName: friend.name)
//        friendsImagesCollectionView.isUserInteractionEnabled = true
//      }
    }
    

   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let friendToDisplay = self.friendToDisplay else {return 0}
        return friendToDisplay.photos.count
    }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let friendToDisplay = self.friendToDisplay else {return UICollectionViewCell()}
        let image = UIImage(named: friendToDisplay.photos[indexPath.row])
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FriendsCollectionViewCell

        cell.friendsImageView.image = image
        return cell
    }
  
  func collectionView(_ collectionView: UICollectionView,
                               willDisplay cell: UICollectionViewCell,
                               forItemAt indexPath: IndexPath) {
    
    cell.alpha = 0
    cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
    UIView.animate(withDuration: 0.8) {
      cell.alpha = 1
      cell.transform = CGAffineTransform(scaleX: 1, y: 1)
      
    }
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      didEndDisplaying cell: UICollectionViewCell,
                      forItemAt indexPath: IndexPath) {
    UIView.animate(withDuration: 0.8) {
      cell.alpha = 0
      cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    selectedIndexPath = indexPath
    let fullScreenGallery = storyboard!.instantiateViewController(withIdentifier: "FullScreenImagePresenter") as! FullScreenImagePresenter
    
    fullScreenGallery.transitioningDelegate = self
    
    fullScreenGallery.friendToDisplay = friendToDisplay
//    fullScreenGallery.imagesToDisplay = imagesToDisplay
    fullScreenGallery.indexPathToScrollTo = selectedIndexPath
    
    present(fullScreenGallery, animated: true, completion: nil )
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let destination = segue.destination as? FullScreenImagePresenter {
        destination.friendToDisplay = friendToDisplay
//        destination.imagesToDisplay = imagesToDisplay
        destination.indexPathToScrollTo = selectedIndexPath
    }
  }
}

extension FriendsCollectionViewController: UIViewControllerTransitioningDelegate {
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return presentTransition
  }
  
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return dismissTransition
  }
}
