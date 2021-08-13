//
//  LogInViewController.swift
//  Traplo
//
//  Created by 김상현 on 2021/08/11.
//


import Foundation
import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import GoogleSignIn

class LoginViewController: UIViewController {
    
    @IBOutlet weak var backGroundBtn: UIButton!
    @IBOutlet weak var btnKakaoLogIn: UIButton!
    @IBOutlet weak var btnGoogleLogIn: UIButton!
    @IBOutlet weak var btnNaverLogIn: UIButton!
    
    let signInConfig = GIDConfiguration.init(clientID: "1087611763983-rm0g3b1ensfk4b34hejfjrdoq4gjcqtk.apps.googleusercontent.com")
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        backGroundBtn.layer.cornerRadius = 40
        
        btnKakaoLogIn.layer.borderColor = UIColor.white.cgColor
        btnKakaoLogIn.layer.borderWidth = 2
        btnKakaoLogIn.layer.cornerRadius = 20
        
        btnGoogleLogIn.layer.borderColor = UIColor.white.cgColor
        btnGoogleLogIn.layer.borderWidth = 2
        btnGoogleLogIn.layer.cornerRadius = 20
        
        btnNaverLogIn.layer.borderColor = UIColor.white.cgColor
        btnNaverLogIn.layer.borderWidth = 2
        btnNaverLogIn.layer.cornerRadius = 20
        
        
    }

    
    @IBAction func signIn(sender: Any) {
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
        guard error == nil else { return }

        // If sign in succeeded, display the app's main content View.
      }
    }
   

    // 카카오로 이용하기 버튼 함수
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
