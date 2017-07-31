    //
//  UserInfo.swift
//  zhitongti
//
//  Created by caobohua on 15/3/13.
//  Copyright (c) 2015年 SC. All rights reserved.
//
//    swift 语言的优势更适合处理这些信息
//借鉴一下即可
import UIKit

class UserInfo: NSObject {
    
    var loginType = ""
    var loginId = ""
    var loginPwd = ""
    var openId = ""
    var expird = NSDate()
    var accessToken = ""
    var code = ""
    var checkinstatus = 0
    var exp = 0
    var lv = 0
    var nickname = ""
    var service = 0
    var star = 0
    var token = ""
    var type = 0
    var userkey = ""
    var username = ""
    var headimg = ""
    var sex = ""
    var coin = 0  //积分
    
    
    var  cert = 0  //证书
    var zttid = ""
    var qq = ""
    var email = ""
    var mobile = ""
    var company = ""
    var department = ""
    var position = ""

    
    var isLogined: Bool = false
    
    let dateFormat = DateFormatter()
    
    override init(){
        super.init()
        dateFormat.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
    }
    
    
    func setInfo(data: [String : AnyObject]){
        checkinstatus = data["checkinstatus"] as! Int
        exp = data["exp"]as! Int
        lv = data["lv"] as! Int
        nickname = data["nickname"]as! String
        service = data["service"] as! Int
        star = data["star"] as! Int
        token = data["token"]as! String
        type = data["type"]as! Int  //个人，企业，管理员
        
        userkey = data["userkey"] as! String
        
//        if data["username"]== nil {
//        
//        data["username"]
//        }
        
        
        
//        var  str : String
     
            username =   data["username"] as! String
     
        
        
        
        
        if data["coin"] != nil {
            coin = data["coin"] as! Int
        }
        if data["cert"] != nil {
            coin = data["coin"] as! Int
        }
        zttid = data["zttid"]as!String
    }
    
    func setInfo(loginType: String, loginId: String, loginPwd: String){
        self.loginType = loginType
        self.loginId = loginId
        self.loginPwd = loginPwd
    }
    
    func setInfo(openId: String, accessToken: String, expird: NSDate, code: String){
        self.openId = openId
        self.expird = expird
        self.accessToken = accessToken
        self.code = code
    }
    
    func save(){
        saveType()
        saveThird()
        saveBase()
        isLogined = true
    }
    
    func saveType(){
        UserDefaults.standard.setValue(loginType, forKey: "rfg")
        UserDefaults.standard.setValue(loginId, forKey: "rfg")
        print(loginPwd)
        UserDefaults.standard.setValue(loginPwd, forKey: "rfg")
//          print(  1222222, UserDefaults.standard.object(forKey: "rfg"))
    }
    
    func saveThird(){
        UserDefaults.standard.setValue(openId, forKey: "user_openId")
        UserDefaults.standard.setValue(dateFormat.string(from: expird as Date), forKey: "user_expird")
        UserDefaults.standard.setValue(accessToken, forKey: "user_accessToken")
        UserDefaults.standard.setValue(nickname, forKey: "user_code")
    }
    func saveBase(){
        UserDefaults.standard.set(checkinstatus, forKey: "user_checkinstatus")
        UserDefaults.standard.set(exp, forKey: "user_exp")
        UserDefaults.standard.set(lv, forKey: "user_lv")
        UserDefaults.standard.setValue(nickname, forKey: "user_nickname")
        UserDefaults.standard.set(service, forKey: "user_service")
        UserDefaults.standard.set(star, forKey: "user_star")
        UserDefaults.standard.setValue(token, forKey: "user_token")
        UserDefaults.standard.set(type, forKey: "user_type")
        UserDefaults.standard.setValue(userkey, forKey: "user_userkey")
        UserDefaults.standard.setValue(username, forKey: "user_username")
        UserDefaults.standard.setValue(headimg, forKey: "user_headimg")
        UserDefaults.standard.setValue(sex, forKey: "user_sex")
        UserDefaults.standard.setValue(coin, forKey: "user_coin")
        UserDefaults.standard.setValue(cert, forKey: "user_cert")

      
        UserDefaults.standard.setValue(zttid, forKey: "user_zttid")
        UserDefaults.standard.setValue(qq, forKey: "user_qq")
        UserDefaults.standard.setValue(email, forKey: "user_email")
        UserDefaults.standard.setValue(mobile, forKey: "user_mobile")
        UserDefaults.standard.setValue(company, forKey: "user_company")
        UserDefaults.standard.setValue(department, forKey: "user_department")
        UserDefaults.standard.setValue(position, forKey: "user_position")
    }
    
    func saveCheckinstatus(){
        UserDefaults.standard.set(checkinstatus, forKey: "user_checkinstatus")
    }
    
    //增加8 企业部门管理员角色
    func isEnterprise() ->Bool{
        return type == 2 || type == 4 || type == 8
    }
    
    static let current = UserInfo()

    func clear(){
        isLogined = false
        
        loginType = ""
//        loginPwd = ""
        loginId = ""
        openId = ""
        accessToken = ""
        expird = NSDate()
        code = ""
        checkinstatus = 0
        exp = 0
        lv = 0
        nickname = ""
        service = 0
        star = 0
        token = ""
        type = 0
        userkey = ""
        username = ""
        headimg = ""
        sex = ""
        coin = 0
        zttid = ""
        
        UserDefaults.standard.removeObject(forKey:"rfg")
        UserDefaults.standard.removeObject(forKey:"rfg")
//        UserDefaults.standard.removeObject(forKey:DefaultsKey.LOGIN_PASSWD)

        UserDefaults.standard.removeObject(forKey: "user_openId")
        UserDefaults.standard.removeObject(forKey: "user_expird")
        UserDefaults.standard.removeObject(forKey: "user_accessToken")
        UserDefaults.standard.removeObject(forKey:"user_code")
        
        UserDefaults.standard.removeObject(forKey:"user_checkinstatus")
        UserDefaults.standard.removeObject(forKey:"user_exp")
        UserDefaults.standard.removeObject(forKey:"user_lv")
        UserDefaults.standard.removeObject(forKey:"user_nickname")
        UserDefaults.standard.removeObject(forKey:"user_service")
        UserDefaults.standard.removeObject(forKey:"user_star")
        UserDefaults.standard.removeObject(forKey:"user_token")
        UserDefaults.standard.removeObject(forKey:"user_type")
        UserDefaults.standard.removeObject(forKey:"user_userkey")
        UserDefaults.standard.removeObject(forKey:"user_username")
        UserDefaults.standard.removeObject(forKey:"user_headimg")
        UserDefaults.standard.removeObject(forKey:"user_sex")
        UserDefaults.standard.removeObject(forKey:"user_coin")
        UserDefaults.standard.removeObject(forKey:"user_zttid")
        
        UserDefaults.standard.removeObject(forKey:"user_qq")
        UserDefaults.standard.removeObject(forKey:"user_email")
        UserDefaults.standard.removeObject(forKey:"user_mobile")
        UserDefaults.standard.removeObject(forKey:"user_company")
        UserDefaults.standard.removeObject(forKey:"user_department")
        UserDefaults.standard.removeObject(forKey:"user_position")
        
    }
    
    static func getCurrent() -> UserInfo{
        if let value = UserDefaults.standard.string(forKey:"rfg") {
            current.loginType = value
        }else{
            current.loginType = ""
        }
        if let value = UserDefaults.standard.string(forKey:"rfg") {
            current.loginId = value
        }else{
            current.loginId = ""
        }
        if let value = UserDefaults.standard.string(forKey:"rfg") {
            current.loginPwd = value
        }else{
            current.loginPwd = ""
        }
        if let value = UserDefaults.standard.string(forKey:"user_nickname") {
            current.nickname = value
        }else{
            current.nickname = ""
        }
        if let value = UserDefaults.standard.string(forKey:"user_token") {
            current.token = value
        }else{
            current.token = ""
        }
        if let value = UserDefaults.standard.string(forKey:"user_userkey") {
            current.userkey = value
        }else{
            current.userkey = ""
        }
        if let value = UserDefaults.standard.string(forKey:"user_username") {
            current.username = value
        }else{
            current.username = ""
        }
        if let value = UserDefaults.standard.string(forKey:"user_openId") {
            current.openId = value
        }else{
            current.openId = ""
        }
        if let value = UserDefaults.standard.string(forKey:"user_expird") {
            current.expird = current.dateFormat.date(from: value)! as NSDate
        }else{
            current.expird = NSDate()
        }
        if let value = UserDefaults.standard.string(forKey:"user_accessToken") {
            current.accessToken = value
        }else{
            current.accessToken = ""
        }
        if let value = UserDefaults.standard.string(forKey:"user_code") {
            current.code = value
        }else{
            current.code = ""
        }
        if let value = UserDefaults.standard.string(forKey:"user_headimg") {
            current.headimg = value
        }else{
            current.headimg = ""
        }
        if let value = UserDefaults.standard.string(forKey: "user_sex") {
            current.sex = value
        }else{
            current.sex = ""
        }
        if let value = UserDefaults.standard.string(forKey:"user_zttid") {
            current.zttid = value
        }else{
            current.zttid = ""
        }
        
        if let value = UserDefaults.standard.string(forKey:"user_qq") {
            current.qq = value
        }else{
            current.qq = ""
        }
        
        if let value = UserDefaults.standard.string(forKey:"user_email") {
            current.email = value
        }else{
            current.email = ""
        }
        
        if let value = UserDefaults.standard.string(forKey:"user_mobile") {
            current.mobile = value
        }else{
            current.mobile = ""
        }
        
        if let value = UserDefaults.standard.string(forKey:"user_company") {
            current.company = value
        }else{
            current.company = ""
        }
        
        if let value = UserDefaults.standard.string(forKey:"user_department") {
            current.department = value
        }else{
            current.department = ""
        }
        
        if let value = UserDefaults.standard.string(forKey:"user_position") {
            current.position = value
        }else{
            current.position = ""
        }
        
        current.checkinstatus = UserDefaults.standard.integer(forKey:
            "user_checkinstatus")
        current.exp = UserDefaults.standard.integer(forKey: "user_exp")
        current.lv = UserDefaults.standard.integer(forKey: "user_lv")
        current.service = UserDefaults.standard.integer(forKey: "user_service")
        current.star = UserDefaults.standard.integer(forKey: "user_star")
        current.type = UserDefaults.standard.integer(forKey: "user_type")
        current.coin = UserDefaults.standard.integer(forKey: "user_coin")
        current.isLogined = false
//        for value in LoginTypeItems{
//            if value == current.loginType{
//                current.isLogined = true
//                break
//            }
//        }
        return current
    }
    
    static func guestPlayList() -> [String]{
        let arr = UserDefaults.standard.array(forKey: "rfg")
        if arr == nil {
            return []
        }
        return arr as! [String]
    }
    
    static func guestAddPlay(captId: String) -> Bool{
        var arr:[AnyObject]? = UserDefaults.standard.array(forKey: "rfg") as [AnyObject]?
        if arr == nil {
            arr = [captId as AnyObject]
            UserDefaults.standard.set(arr, forKey: "rfg")
            return true
        }
        let tmparr = arr as! [String]
        for value in tmparr {
            if value == captId {
                return true
            }
        }
        if arr!.count > 9 {
            return false
        }
        arr!.append(captId as AnyObject)
        UserDefaults.standard.set(arr, forKey: "rfg")
        return true
    }
    
}

class LoginHelper{
    class func isLogin()->Bool{
        /*
        let loginType = UserDefaults.standard.string(forKey:DefaultsKey.LOGIN_TYPE)
        if loginType == nil{
            return false
        }
        for value in LoginTypeItems{
            if value == loginType{
                return true
            }
        }
        return false
        */
        return UserInfo.current.isLogined
    }
    
    class func logout(){
        UserInfo.current.clear()
        UserDefaults.standard.set(false, forKey: "isLogin")
    }
    
    class func upLevelAlert(data: [String: Int]){
        UserInfo.current.coin = data["coin"]!
        UserInfo.current.lv = data["level"]!
        UserInfo.current.star = data["star"]!
        UserInfo.current.exp = data["exp"]!
        UserInfo.current.saveBase()
        let isUpLevel = data["isUpLevel"]!
        let isUpStar = data["isUpStar"]!
        var alertmsg = ""
        if isUpStar != 0 && isUpStar != 0 {
            alertmsg = "恭喜，您的等级提升至\(UserInfo.current.lv)和星级提升至\(UserInfo.current.star)了"
        }else if isUpStar == 0 && isUpLevel != 0 {
            alertmsg = "恭喜，您的星级提升至\(UserInfo.current.star)"
        }else if isUpLevel == 0 && isUpStar != 0 {
            alertmsg = "恭喜，您的等级提升至\(UserInfo.current.lv)"
        }else{
            return
        }
        let alert = UIAlertView()
        alert.title = "恭喜"
        alert.message = alertmsg
        alert.cancelButtonIndex = alert.addButton(withTitle: "确定")
        alert.show()
    }
    
    
    
}
