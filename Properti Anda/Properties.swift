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
        self.properties.append(
            Property(address: "205-215 Bell St, Preston", price: 300000, progressPrice: 10000, completed: false, investors: 10, detail: "Located 25 minutes west of Jakarta, Citra Raya Tangerang is a self-sustaining city that can be reached through Jakarta-Merak toll access. This area has been developed since 1994 by the Ciputra group and started to gain momentum growth since 2014.", imageURL: "http://admin.propertianda.com/images/property_list/4941be93f51f319db0659f51a1f1e0b5.jpg")
        )
        self.properties.append(
            Property(address: "200 Raglan St, Thornbury", price: 4500000, progressPrice: 234000, completed: false, investors: 25, detail: "Cluster Portofino is part of the Villagio mega cluster located near the new toll lane Serpong - Balaraja - Soerkarno-Hatta airport. Mega cluster Villagio itself offers ruko & house width 6, 7, and 8. ", imageURL: "http://admin.propertianda.com/images/property_list/c22fb807bed7ec2bca561570ad2d11ca.png")
        )
        self.properties.append(
            Property(address: "100 Willmore Ln, Northcote", price: 500000, progressPrice: 500000, completed: true, investors: 43, detail: "From the rental side itself, this 1-floor and 2-bedroom unit will have a wider audience especially from industrial companies in the surrounding location and the rental fee would be cheaper, when compared to the type with width 6 which is smaller size and width 8 more pricey, width 7 is the perfect one because the rental price will be more competitive.", imageURL: "http://admin.propertianda.com/images/property_list/6990b29c649c436aa2008029e60cd9f0.jpg")
        )
        self.properties.append(
            Property(address: "304 Skycrapper St, St Kilda", price: 1200000, progressPrice: 100000, completed: false, investors: 20, detail: "It has a total area of 2760 Ha and newly developed 1000 Ha since 1994, with 54 clusters and 25,000 units built and populated 65,000 inhabitants. This provides a space of growth for investment and confidence in growth.", imageURL: "http://admin.propertianda.com/images/property_list/cda80cfcec0aada8fede09c171dd44bc.png")
        )
    }
    
    public func requestProperties(callback: @escaping () -> Any){
        Alamofire.request("https://httpbin.org/get").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let body = response.result.value {
                let json = JSON(body)
                self.parsePropertiesJson(json: json, callback: callback)
            }
        }
    }
    
    private func parsePropertiesJson(json: JSON, callback: ()->Any){
        print("JSON: \(json)") // serialized json response
        var _ = callback()
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
    
    init(){}
    init(address:String){
        self.address = address
    }
    init(address:String, price:Double, progressPrice:Double, completed:Bool, investors:Int, detail:String){
        self.address = address
        self.price = price
        self.progressPrice = progressPrice
        self.completed = completed
        self.investors = investors
        self.detail = detail
    }
    
    convenience init(address:String, price:Double, progressPrice:Double, completed:Bool, investors:Int, detail:String, imageURL:String){
        self.init(address:address, price:price, progressPrice:progressPrice, completed:completed, investors: investors, detail:detail)
        self.imageURL = imageURL
    }
    
    public func getAddress()->String{
        return self.address
    }
    
    public func getPrice()->Double{
        return self.price
    }
    
    public func getPrice(formatted: Bool)->String{
        if formatted {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = NumberFormatter.Style.decimal
            return "$" + numberFormatter.string(from: NSNumber(value:self.price))!
        }else{
            return String(self.price)
        }
    }
    
    public func isCompleted()->Bool{
        return self.completed
    }
    
    public func getProgressPrice()->Double{
        return self.progressPrice
    }
    public func getProgressPrice(formatted: Bool)->String{
        if formatted {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = NumberFormatter.Style.decimal
            return "of $" + numberFormatter.string(from: NSNumber(value:self.progressPrice))!
        }else{
            return String(self.getProgressPrice())
        }
    }
    
    public func getDetail()->String{
        return self.detail
    }
    
    public func getImageURL()->String{
        return self.imageURL
    }
    
}
