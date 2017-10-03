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
    
    public func requestProperties(callback: @escaping () -> ()){
        self.properties = []
        PARequest.getProperties(){props in
            self.properties = props
            callback()
        }
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
    var share:Int = 0
    
    init(){}
    init(address:String){
        self.address = address
    }
    init(address:String, price:Double, progressPrice:Double, completed:Bool, investors:Int, detail:String, id:String, share: Int){
        self.address = address
        self.price = price
        self.progressPrice = progressPrice
        self.completed = completed
        self.investors = investors
        self.detail = detail
        self.id = id
        self.share = share
    }
    
    convenience init(address:String, price:Double, progressPrice:Double, completed:Bool, investors:Int, detail:String, imageURL:String, id: String, share: Int){
        self.init(address:address, price:price, progressPrice:progressPrice, completed:completed, investors: investors, detail:detail, id: id, share:share)
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
        PARequest.getProperty(id: self.id){prop in
            self.detail = prop.getDetail()
            self.latitude = prop.getLatitude()
            self.longitude = prop.getLongitude()
        }
    }
    
    public func getPrice(formatted: Bool, independent: Bool = false)->String{
        if formatted {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = NumberFormatter.Style.decimal
            return (independent ? "" : "of ") + "$" + numberFormatter.string(from: NSNumber(value:self.price / 10560))!
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
