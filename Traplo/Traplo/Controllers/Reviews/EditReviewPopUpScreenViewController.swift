//
//  EditReviewPopUpScreenViewController.swift
//  Traplo
//
//  Created by 김상현 on 2021/08/23.
//

import UIKit

class EditReviewPopUpScreenViewController: UIViewController {

    @IBOutlet weak var popUpScreenView: UIView!
    @IBOutlet weak var activityCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    

    func setUI() {
        popUpScreenView.layer.cornerRadius = 30
        activityCollectionView.layer.cornerRadius = 30
        activityCollectionView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
        
    }

    @IBAction func onClickedXBtn(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
}

extension EditReviewPopUpScreenViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "activityCollectionViewCell", for: indexPath) as? activityCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        
      return cell


    }
    
    
}

extension EditReviewPopUpScreenViewController:UICollectionViewDelegateFlowLayout {
    
}

class activityCollectionViewCell : UICollectionViewCell{
    
}
