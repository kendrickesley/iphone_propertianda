//
//  Properties.swift
//  Properti Anda
//
//  Created by Kendrick on 22/8/17.
//  Copyright © 2017 Kendrick. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Properties{
    var properties:[Property] = []
    
    init(properties:[Property]){
        self.properties = properties
    }
    
    init(){

    }
    
    public func requestProperties(callback: @escaping () -> Any){
        Alamofire.request("https://propertianda.com/php_dev/property_requester.php").responseJSON { response in
            print("Result: \(response.result)")                         // response serialization result
            
            if let body = response.result.value {
                let json = JSON(body)
                self.parsePropertiesJson(json: json, callback: callback)
            }
        }
    }
    
    private func parsePropertiesJson(json: JSON, callback: ()->Any){
        let properties: JSON = JSON(json["all_row"].arrayValue)
        let images: JSON = JSON(json["images"].dictionaryValue)
        for (_,property):(String, JSON) in properties {
            self.properties.append(Property(address: property["address"].stringValue, price: property["property_price"].doubleValue, progressPrice: property["funded"].doubleValue / property["share_issued"].doubleValue * property["property_price"].doubleValue, completed: property["status"].intValue == 1, investors: property["investorCount"].intValue, detail: "", imageURL: images[property["id"].stringValue].arrayValue.count > 0 ? images[property["id"].stringValue].arrayValue[0]["pic_path"].stringValue : "", id: property["id"].stringValue))
        }
        let _ = callback()
    }
    
    public func getAllProperties()->[Property]{
        return properties
    }
    public func getProperty(byIndex:Int)->Property{
        if byIndex < properties.count {
            return properties[byIndex]
        }else{
            return Property(address:"Default")
        }
    }
}

class Property{
    var address:String = ""
    var price:Double = 0
    var completed:Bool = false
    var progressPrice:Double = 0
    var investors:Int = 0
    var detail:String = ""
    var imageURL:String = ""
    var id:String = ""
    var latitude:Double = 0
    var longitude: Double = 0
    
    init(){}
    init(address:String){
        self.address = address
    }
    init(address:String, price:Double, progressPrice:Double, completed:Bool, investors:Int, detail:String, id:String){
        self.address = address
        self.price = price
        self.progressPrice = progressPrice
        self.completed = completed
        self.investors = investors
        self.detail = detail
        self.id = id
    }
    
    convenience init(address:String, price:Double, progressPrice:Double, completed:Bool, investors:Int, detail:String, imageURL:String, id: String){
        self.init(address:address, price:price, progressPrice:progressPrice, completed:completed, investors: investors, detail:detail, id: id)
        self.imageURL = imageURL
    }
    
    public func getAddress()->String{
        return self.address
    }
    
    public func getPrice()->Double{
        return self.price
    }
    
    public func getInvestors()->String{
        return String(self.investors)
    }
    
    public func requestDetail(callback: @escaping () -> Any){
        let params = [
            "mode": "detail",
            "propertyid": self.id
        ]
        Alamofire.request("https://propertianda.com/php_dev/property_requester.php", method: .post, parameters: params).responseJSON { response in
            print("Result: \(response.result)")                         // response serialization result
            
            if let body = response.result.value {
                let json = JSON(body)
                self.parseDetailJson(json: json, callback: callback)
            }
        }
    }
    
    private func parseDetailJson(json: JSON, callback: ()->Any){
        let properties: JSON = JSON(json["all_row"].arrayValue)
        if properties.count <= 0 {
            return
        }
        let property = JSON(properties[0].dictionaryValue)
        self.detail = property["property_detail_content"].stringValue
        self.latitude = property["latitude"].doubleValue
        self.longitude = property["longitude"].doubleValue
        let _ = callback()
    }
    
    public func getPrice(formatted: Bool)->String{
        if formatted {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = NumberFormatter.Style.decimal
            return "$" + numberFormatter.string(from: NSNumber(value:self.price / 10560))!
        }else{
            return String(self.price)
        }
    }
    
    public func isCompleted()->Bool{
        return self.completed
    }
    
    public func getLatitude()->Double{
        return self.latitude
    }
    
    public func getLongitude()->Double{
        return self.longitude
    }
    
    public func getProgressPrice()->Double{
        return self.progressPrice
    }
    public func getProgressPrice(formatted: Bool, independent: Bool = false)->String{
        if formatted {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = NumberFormatter.Style.decimal
            return (independent ? "" : "of ") + "$" + numberFormatter.string(from: NSNumber(value:self.progressPrice / 10560))!
        }else{
            return String(self.getProgressPrice())
        }
    }
    
    public func getID()->String{
        return self.id
    }
    
    public func getDetail()->String{
        return self.detail
    }
    
    public func getImageURL()->String{
        return self.imageURL
    }
    
}
