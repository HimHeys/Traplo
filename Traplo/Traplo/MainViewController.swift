//
//  ViewController.swift
//  Traplo
//
//  Created by 김상현 on 2021/08/09.
//

import UIKit
import KakaoSDKUser

class MainViewController: UIViewController {

    @IBOutlet weak var btnSignIn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnSignIn.layer.borderColor = UIColor.white.cgColor
        btnSignIn.layer.borderWidth = 2
        btnSignIn.layer.cornerRadius = 10

       

    }
    
//    @IBAction func pushBtnSignIn(_ sender: Any) {
//        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
//        vcName?.modalPresentationStyle = .overFullScreen
//        vcName?.modalPresentationStyle = .overCurrentContext
//        self.present(vcName!, animated: true, completion: nil)
//    }
//
    @IBAction func onKakaoLoginByAppTouched(_ sender: Any) {
     // 카카오톡 설치 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
        // 카카오톡 로그인. api 호출 결과를 클로저로 전달.
        UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
            if let error = error {
                // 예외 처리 (로그인 취소 등)
                print(error)
            }
            else {
                print("loginWithKakaoTalk() success.")
               // do something
                _ = oauthToken
               // 어세스토큰
               let accessToken = oauthToken?.accessToken
            }
        }
      }
    }
    
}
