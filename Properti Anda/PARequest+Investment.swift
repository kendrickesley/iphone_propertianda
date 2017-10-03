//
//  PARequest+Investment.swift
//  Properti Anda
//
//  Created by Kendrick on 3/10/17.
//  Copyright © 2017 Kendrick. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

extension PARequest {
    public static func getInvestments(callback: @escaping([Investment]) -> ()){
        let app:AppState? = AppStateModel.sharedInstance.getAppState()
        let userID:String = app?.user_id ?? ""
        let parameters: Parameters = [
            "userid": userID,
            "token": app?.token ?? "",
            "mode": "all_owned_share"
        ]
        Alamofire.request("https://propertianda.com/php_dev/market_requester.php", method: .post, parameters:parameters).responseJSON { response in
            var invs:[Investment] = []
            if let body = response.result.value {
                let json = JSON(body)
                invs = PARequest.parseInvestmentsJson(json: json)
            }
            callback(invs)
        }
    }
    
    private static func parseInvestmentsJson(json: JSON)->[Investment]{
        var invs:[Investment] = []
        let investments: JSON = JSON(json["all_row"].arrayValue)
        for (_,investment):(String, JSON) in investments {
            var contribution: Double = 0
            let details: JSON = JSON(investment["details"].arrayValue)
            for(_,detail):(String, JSON) in details {
                contribution += Double(detail["share"].intValue) * detail["price"].doubleValue
            }
            invs.append(Investment(address: investment["address"].stringValue, price: investment["property_price"].doubleValue, imageURL: investment["picture"].stringValue, contribution: contribution, id: investment["property_id"].stringValue))
        }
        return invs
    }
}
