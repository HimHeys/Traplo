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
import NaverThirdPartyLogin

import Alamofire


class LoginViewController: UIViewController {
    
    @IBOutlet weak var backGroundBtn: UIButton!
    @IBOutlet weak var btnKakaoLogIn: UIButton!
    @IBOutlet weak var btnGoogleLogIn: UIButton!
    @IBOutlet weak var btnNaverLogIn: UIButton!
    
    // 구글
    let signInConfig = GIDConfiguration.init(clientID: "1087611763983-rm0g3b1ensfk4b34hejfjrdoq4gjcqtk.apps.googleusercontent.com")
    
    // 네이버
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
 
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

    
    // 구글로 이용하기 버튼 함수
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
    
    // 네이버로 이용하기 버튼 함수
    @IBAction func onNaverLoginByAppTouched(_ sender: UIButton) {
      loginInstance?.delegate = self
      loginInstance?.requestThirdPartyLogin()
    }
    
    private func getNaverInfo() {
      guard let isValidAccessToken = loginInstance?.isValidAccessTokenExpireTimeNow() else { return }
      
      if !isValidAccessToken {
        
        return
      }
      
      guard let tokenType = loginInstance?.tokenType else { return }
      guard let accessToken = loginInstance?.accessToken else { return }
      let urlStr = "https://openapi.naver.com/v1/nid/me"
      let url = URL(string: urlStr)!
//
//      let authorization = "\(tokenType) \(accessToken)"
//
//      let req = Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": authorization])
//
//      req.responseJSON { response in
//        guard let result = response.result.value as? [String: Any] else { return }
//        guard let object = result["response"] as? [String: Any] else { return }
//        guard let name = object["name"] as? String else { return }
//        guard let email = object["email"] as? String else { return }
//        guard let nickname = object["nickname"] as? String else { return }
//
//        print(name+" "+email+" "+nickname)
//        self.nameLabel.text = "\(name)"
//        self.emailLabel.text = "\(email)"
//        self.nicknameLabel.text = "\(nickname)"
      }
    }

// 네이버
extension LoginViewController: NaverThirdPartyLoginConnectionDelegate {
  // 로그인에 성공했을 경우 호출
  func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
    print("[Success] : Success Naver Login")
    getNaverInfo()
  }
  
  // 접근 토큰 갱신
  func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
    
  }
  
  // 로그아웃 할 경우 호출(토큰 삭제)
  func oauth20ConnectionDidFinishDeleteToken() {
    loginInstance?.requestDeleteToken()
  }
  
  // 모든 Error
  func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
    print("[Error] :", error.localizedDescription)
  }
}
