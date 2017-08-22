//
//  Properties.swift
//  Properti Anda
//
//  Created by Kendrick on 22/8/17.
//  Copyright © 2017 Kendrick. All rights reserved.
//

import Foundation

class Properties{
    var properties:[Property] = []
    
    init(properties:[Property]){
        self.properties = properties
    }
    
    init(){
        self.properties.append(
            Property(address: "205-215 Bell St, Preston", price: 300000, progressPrice: 10000, completed: false, investors: 10)
        )
        self.properties.append(
            Property(address: "200 Raglan St, Thornbury", price: 4500000, progressPrice: 234000, completed: false, investors: 25)
        )
        self.properties.append(
            Property(address: "100 Willmore Ln, Northcote", price: 500000, progressPrice: 500000, completed: true, investors: 43)
        )
        self.properties.append(
            Property(address: "304 Skycrapper St, St Kilda", price: 1200000, progressPrice: 100000, completed: false, investors: 20)
        )
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
    
    init(){}
    init(address:String){
        self.address = address
    }
    init(address:String, price:Double, progressPrice:Double, completed:Bool, investors:Int){
        self.address = address
        self.price = price
        self.progressPrice = progressPrice
        self.completed = completed
        self.investors = investors
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
    
}
