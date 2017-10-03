//
//  PARequest+Login.swift
//  Properti Anda
//
//  Created by Kendrick on 3/10/17.
//  Copyright © 2017 Kendrick. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SwiftSpinner

extension PARequest{
    public static func login(email:String, password:String, callback: @escaping (_ success:Bool)->()){
        let appState = AppStateModel.sharedInstance
        appState.getAppStates()
        let parameters: Parameters = [
            "email": email,
            "password": password,
            "mode": "sign_in"
        ]
        Alamofire.request("https://propertianda.com/php_dev/user_auth.php", method: .post, parameters: parameters).responseJSON { response in
            print("Result: \(response.result)")                         // response serialization result
            
            if let body = response.result.value {
                let json = JSON(body)
                print("Body: \(json)")
                if json["status"].stringValue == "OK"{
                    appState.saveAuth(email: json["email"].stringValue, firstName: json["first_name"].stringValue, lastName: json["last_name"].stringValue, token: json["token"].stringValue, userID: json["id"].stringValue, existing: appState.getAppState()!)
                }
                callback(json["status"].stringValue == "OK")
            }
        }

    }
    
    public static func token_login(callback: @escaping (_ success: Bool)->()){
        let appState = AppStateModel.sharedInstance
        appState.getAppStates()
        let app:AppState? = appState.getAppState()
        if(app != nil && app?.token != nil && (app?.token?.characters.count)! > 0 && app?.email != nil && (app?.email?.characters.count)! > 0 && app?.first_name != nil && (app?.first_name?.characters.count)! > 0 && app?.last_name != nil && (app?.last_name?.characters.count)! > 0){
            SwiftSpinner.show("Logging in...")
            let parameters: Parameters = [
                "email": app?.email ?? "",
                "token": app?.token ?? "",
                "mode": "check_token"
            ]
            Alamofire.request("https://propertianda.com/php_dev/user_auth.php", method: .post, parameters: parameters).responseJSON { response in
                print("Result: \(response.result)")                         // response serialization result
                SwiftSpinner.hide()
                if let body = response.result.value {
                    let json = JSON(body)
                    print("Body: \(json)")
                    if json["status"].stringValue != "OK"{
                        appState.clearAuth(existing: app!)
                    }
                    callback(json["status"].stringValue == "OK")
                }
            }
        }
    }
}
