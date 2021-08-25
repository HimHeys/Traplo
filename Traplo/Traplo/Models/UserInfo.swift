//
//  UserInfo.swift
//  Traplo
//
//  Created by 김상현 on 2021/08/25.
//

import Foundation

// 현재 로그인한 유저의 정보
class UserInfo {
    // 싱글톤~
    static var shared = UserInfo()
    
    var userId :String
    var name : String
    //var profileImage
    var email : String
    init(userId:String = "ID",name:String = "이름",email:String = "email") {
        self.userId = userId
        self.name = name
        self.email = email
    }
    
}
