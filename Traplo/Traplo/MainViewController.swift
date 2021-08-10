//
//  ViewController.swift
//  Traplo
//
//  Created by 김상현 on 2021/08/09.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnSignIn.layer.borderColor = UIColor.white.cgColor
        btnSignIn.layer.borderWidth = 2
        btnSignIn.layer.cornerRadius = 10

        btnSignUp.layer.borderColor = UIColor.white.cgColor
        btnSignUp.layer.borderWidth = 2
        btnSignUp.layer.cornerRadius = 10

    }
    
    @IBAction func pushBtnSignIn(_ sender: Any) {
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
        vcName?.modalPresentationStyle = .overFullScreen
        vcName?.modalPresentationStyle = .overCurrentContext
        self.present(vcName!, animated: true, completion: nil)
    }
    
}
