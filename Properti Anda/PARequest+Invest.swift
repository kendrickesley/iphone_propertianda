//
//  PARequest+Invest.swift
//  Properti Anda
//
//  Created by Kendrick on 3/10/17.
//  Copyright © 2017 Kendrick. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

extension PARequest {
    public static func invest(share:Int, property_id: String, wallet_request: Double, callback: @escaping(_ success: Bool)->()){
        AppStateModel.sharedInstance.getAppStates()
        let app:AppState? = AppStateModel.sharedInstance.getAppState()
        let userID:String = app?.user_id ?? ""
        let email:String = app?.email ?? ""
        let token: String = app?.token ?? ""
        let parameters: Parameters = [
            "email": email,
            "shares": share,
            "propertyid": property_id,
            "token": token,
            "userid": userID,
            "mode": "company_buy",
            "wallet_request": wallet_request
        ]
        Alamofire.request("https://propertianda.com/php_dev/market_requester.php", method: .post, parameters: parameters).responseJSON { response in
            print("Result: \(response.result)")                         // response serialization result
            
            if let body = response.result.value {
                let json = JSON(body)
                print("Body: \(json)")
                callback(json["status"].stringValue == "OK")
            }
        }
    }
}
