//
//  listSearchTouristSpotViewController.swift
//  Traplo
//
//  Created by 김상현 on 2021/08/28.
//

import UIKit

// 관광지 검색한 후 -list 페이지
class ListSearchTouristSpotViewController: UIViewController {
    
    //gradient
    var gradientLayer: CAGradientLayer!
    
    //UIColor
    let topDesignColor1 = UIColor(named: "Color2")?.cgColor
    let topDesignColor2 = UIColor(named: "Color1")?.cgColor
    @IBOutlet weak var topDesignView: UIView!
    @IBOutlet weak var topDesignLayoutView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()

    }
    
    func setUI() {
        setTopGradationDesign()
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
}
