//
//  LoginViewController.swift
//  Traplo
//
//  Created by 김상현 on 2021/08/10.
//

import Foundation
import UIKit
import KakaoSDKAuth
import KakaoSDKUser

class LoginViewController: UIViewController {
    
    @IBOutlet var superView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        
        
    }
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
