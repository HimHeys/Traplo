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
        
        setUI()
        loginInstance?.resetToken()
    
    }
    func setUI(){
        
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
    
    func logInCompleted()  {
        
        let sb = UIStoryboard(name: "Activity", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "RecommendActivityViewController") as! RecommendActivityViewController
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
        
    }
    // 카카오,네이버 서버 통신
    func AFRequestByToken(authorization:String,com:String){
        
        let urlStr = "http://3.35.202.118:8080/api/v1/members/"+com
        let url = URL(string: urlStr)!

        let req = AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: ["Authorization": authorization])
               
        req.responseJSON { response in
            print(response.result)
//          guard let result = response.result as? [String: Any] else { return }
//          guard let object = result["response"] as? [String: Any] else { return }
//          guard let name = object["name"] as? String else { return }
//          guard let email = object["email"] as? String else { return }
//          print(name+" "+email)
        }
    }
    // 구글 토큰 서버 통신
    func AFRequestByTokenGoogle(authorization:String){
        let urlStr = "http://3.35.202.118:8080/api/v1/members/google"
        let url = URL(string: urlStr)!

        let req = AF.request(url, method: .post, parameters: nil, encoding: URLEncoding.default, headers: ["Authorization": authorization])
               
        req.responseJSON { response in
            print(response.result)
//          guard let result = response.result as? [String: Any] else { return }
//          guard let object = result["response"] as? [String: Any] else { return }
//          guard let name = object["name"] as? String else { return }
//          guard let email = object["email"] as? String else { return }
//          print(name+" "+email)
        }
    }

    
    // 구글로 이용하기 버튼 함수
    @IBAction func signIn(sender: Any) {
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
        guard error == nil else { return }
        guard let user = user else { return }
            
        user.authentication.do { authentication, error in
            guard error == nil else { return }
            guard let authentication = authentication else { return }
            
            guard let authorization = authentication.idToken else {return}
            self.AFRequestByTokenGoogle(authorization: authorization)
            
            }
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
               guard let accessToken = oauthToken?.accessToken else {return}
               let authorization = "\(accessToken)"

                self.AFRequestByToken(authorization: authorization,com: "oauthKakao")
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
        guard let accessToken = loginInstance?.accessToken else { return }

        let authorization = "\(accessToken)"
        AFRequestByToken(authorization: authorization,com: "oauthNaver")
        
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
