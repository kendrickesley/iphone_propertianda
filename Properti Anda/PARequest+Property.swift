//
//  PARequest+Property.swift
//  Properti Anda
//
//  Created by Kendrick on 3/10/17.
//  Copyright © 2017 Kendrick. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

//Facade to request a single property
extension PARequest{
    
    public static func getProperty(id: String, callback: @escaping(Property)->()){
        let params = [
            "mode": "detail",
            "propertyid": id
        ]
        //Request to the REST based API
        Alamofire.request("https://propertianda.com/php_dev/property_requester.php", method: .post, parameters: params).responseJSON { response in
            print("Result: \(response.result)")                         // response serialization result
            var prop = Property()
            if let body = response.result.value {
                let json = JSON(body)
                prop = PARequest.parseDetailJson(json: json)
            }
            callback(prop)
        }
    }
    
    //parse the given JSON to a Property object
    private static func parseDetailJson(json: JSON)->Property{
        let properties: JSON = JSON(json["all_row"].arrayValue)
        let prop = Property()
        if properties.count <= 0 {
            return prop
        }
        let property = JSON(properties[0].dictionaryValue)
        prop.detail = property["property_detail_content"].stringValue
        prop.latitude = property["latitude"].doubleValue
        prop.longitude = property["longitude"].doubleValue
        return prop
    }

    
    public static func getProperties(callback: @escaping ([Property]) -> ()){
        Alamofire.request("https://propertianda.com/php_dev/property_requester.php").responseJSON { response in
            print("Result: \(response.result)")                         // response serialization result
            var props:[Property] = []
            if let body = response.result.value {
                let json = JSON(body)
                props = PARequest.parsePropertiesJson(json: json)
            }
            callback(props)
        }
    }
    
    private static func parsePropertiesJson(json: JSON)->[Property]{
        var props:[Property] = []
        let properties: JSON = JSON(json["all_row"].arrayValue)
        let images: JSON = JSON(json["images"].dictionaryValue)
        for (_,property):(String, JSON) in properties {
            props.append(Property(address: property["address"].stringValue, price: property["property_price"].doubleValue, progressPrice: property["funded"].doubleValue / property["share_issued"].doubleValue * property["property_price"].doubleValue, completed: property["status"].intValue == 1, investors: property["investorCount"].intValue, detail: "", imageURL: images[property["id"].stringValue].arrayValue.count > 0 ? images[property["id"].stringValue].arrayValue[0]["pic_path"].stringValue : "", id: property["id"].stringValue, share: property["share_issued"].intValue))
        }
        return props
    }
}
