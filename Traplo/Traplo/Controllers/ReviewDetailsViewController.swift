//
//  ReviewDetailsViewController.swift
//  Traplo
//
//  Created by 김상현 on 2021/08/17.
//

import UIKit

class ReviewDetailsViewController: UIViewController {

    @IBOutlet weak var topDesignView: UIView!
    @IBOutlet weak var topDesignLayoutView: UIView!
    
    var gradientLayer: CAGradientLayer!
    
    let topDesignColor1 = UIColor(named: "Color2")?.cgColor
    let topDesignColor2 = UIColor(named: "Color1")?.cgColor
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    func setUI() {
        // 상단 그라데이션 디자인
               self.gradientLayer = CAGradientLayer()
               self.gradientLayer.frame = topDesignView.bounds
               self.gradientLayer.colors = [topDesignColor1 as Any,topDesignColor2 as Any]
               self.gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
               self.gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
               self.topDesignView.layer.addSublayer(self.gradientLayer)
       
               self.topDesignView.bringSubviewToFront(topDesignLayoutView)
           
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
