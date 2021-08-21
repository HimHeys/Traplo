//
//  ReviewDetailsViewController.swift
//  Traplo
//
//  Created by 김상현 on 2021/08/17.
//

import UIKit
import GoogleMaps
import Cosmos

class ReviewDetailsViewController: UIViewController {
    
    //view
    @IBOutlet weak var topDesignView: UIView!
    @IBOutlet weak var topDesignLayoutView: UIView!
    @IBOutlet weak var mapFrameView: UIView!
    @IBOutlet weak var ploggingConsole: UIView!
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var bottomDesignView: UIView!
    
    //constraints
    @IBOutlet weak var topDesignViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var mapFrameViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var ploggingConsoleUpperConstraint:NSLayoutConstraint!
    @IBOutlet weak var ploggingConsoleUnderConstraint:NSLayoutConstraint!
    @IBOutlet weak var collectionViewUpperConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    //gradient
    var gradientLayer: CAGradientLayer!
    
    let topDesignColor1 = UIColor(named: "Color2")?.cgColor
    let topDesignColor2 = UIColor(named: "Color1")?.cgColor
    
    let defaultReviewImage = UIImage.init(imageLiteralResourceName: "Rectangle 58")
    let defaultAddReviewImage = UIImage.init(imageLiteralResourceName: "Group 8")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

    override func viewDidAppear(_ animated: Bool) {
      
        setGoogleMaps() // setUI() 로 옮기면 안됨!! <layout배열 꼬임>
        setTopGradationDesign()
    }

    func setUI() {
        // height 설정
        let viewHeight = view.bounds.height
        let topDesignViewHeight : CGFloat = viewHeight/10
        let mapFrameViewHeight : CGFloat = (viewHeight-topDesignViewHeight)/3
        let collectionUpperConstraint = topDesignViewHeight + 20
        let collectionRectCellSize = viewHeight/6
        
        
        topDesignViewHeightConstraint.constant =  -(topDesignViewHeight)
        mapFrameViewHeightConstraint.constant = -(mapFrameViewHeight*1.5)
        ploggingConsoleUpperConstraint.constant = (-topDesignViewHeight)
        ploggingConsoleUnderConstraint.constant = topDesignViewHeight
        collectionViewUpperConstraint.constant = collectionUpperConstraint
        collectionViewHeightConstraint.constant = -(collectionUpperConstraint+collectionRectCellSize)
        
        setPloggingConsole()
        setCosmosRate()
    }
    
    // 상단 그라데이션 디자인
    func setTopGradationDesign() {
        
        self.gradientLayer = CAGradientLayer()
        self.gradientLayer.frame = topDesignView.bounds
        self.gradientLayer.colors = [topDesignColor1 as Any,topDesignColor2 as Any]
        self.gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        self.gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        self.topDesignView.layer.addSublayer(self.gradientLayer)

        self.topDesignView.bringSubviewToFront(topDesignLayoutView)
    }
    
    // Google Maps
    func setGoogleMaps() {
        let camera = GMSCameraPosition.camera(withLatitude: 37.566508, longitude: 126.977945, zoom: 16.0)
        let mapView = GMSMapView.map(withFrame: self.mapFrameView.bounds, camera: camera)
              self.mapFrameView.addSubview(mapView)

              // Creates a marker in the center of the map.
              let marker = GMSMarker()
              marker.position = CLLocationCoordinate2D(latitude: 37.566508, longitude: 126.977945)
              marker.title = "Sydney"
              marker.snippet = "South Korea"
              marker.map = mapView
    }

    func setPloggingConsole() {
        ploggingConsole.layer.cornerRadius = 30
    }
    
    func setCosmosRate() {
        
    }

}
extension ReviewDetailsViewController : UICollectionViewDataSource {
    
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewImages", for: indexPath) as? addImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        
        cell.collectionViewImageView.image = defaultReviewImage


        return cell
    }
    
    
}

extension ReviewDetailsViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let viewHeight = view.bounds.height
        let collectionRectCellSize = viewHeight/6

        
        return CGSize(width: collectionRectCellSize, height: collectionRectCellSize)
    }
}

extension ReviewDetailsViewController : UICollectionViewDelegate {
    
}

class addImageCollectionViewCell : UICollectionViewCell {
    @IBOutlet weak var collectionViewImageView: UIImageView!

}
