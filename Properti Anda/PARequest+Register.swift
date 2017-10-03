//
//  PARequest+Register.swift
//  Properti Anda
//
//  Created by Kendrick on 3/10/17.
//  Copyright © 2017 Kendrick. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

//facade to register a user
extension PARequest{
    
    public static func register(email: String, password: String, firstName: String, lastName: String, id_number:String, callback: @escaping (_ success: Bool)->()){
        let parameters: Parameters = [
            "email": email,
            "password": password,
            "fullname": firstName + " " + lastName,
            "id_number": id_number,
            "mode": "sign_up"
        ]
        //create a request to the REST based API with the given parameters
        Alamofire.request("https://propertianda.com/php_dev/user_auth.php", method: .post, parameters: parameters).responseJSON { response in
            print("Result: \(response.result)")                         // response serialization result
            if let body = response.result.value {
                let json = JSON(body)
                print("Body: \(json)")
                callback(json["status"].stringValue == "OK")
            }
        }
    }
}
