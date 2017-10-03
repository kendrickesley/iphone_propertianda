//
//  Investments.swift
//  Properti Anda
//
//  Created by Kendrick on 26/9/17.
//  Copyright © 2017 Kendrick. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

//Class to manage all the investments
class Investments{
    var investments:[Investment] = []
    
    init(investments:[Investment]){
        self.investments = investments
    }
    
    init(){
    }
    
    //request investments through a facade
    public func requestInvestments(callback: @escaping () -> ()){
        self.investments = []
        PARequest.getInvestments(){invs in
            self.investments = invs
            callback()
        }
    }
    
    //get all investments
    public func getAllInvestments()->[Investment]{
        return investments
    }
    
    //get an investment by an index
    public func getInvestment(byIndex:Int)->Investment{
        if byIndex < investments.count {
            return investments[byIndex]
        }else{
            return Investment(address:"Default")
        }
    }
}

//class to manage a single investment
class Investment{
    //required attributes
    var address:String = ""
    var price:Double = 0
    var imageURL:String = ""
    var id:String = ""
    var contribution:Double = 0
    
    init(){}
    
    //simplest initialization
    init(address:String){
        self.address = address
    }
    
    //initialization of property
    init(address:String, price:Double, id:String){
        self.address = address
        self.price = price
        self.id = id
    }
    
    //complete intialization
    convenience init(address:String, price:Double, imageURL:String, contribution: Double, id: String){
        self.init(address:address, price:price, id: id)
        self.imageURL = imageURL
        self.contribution = contribution
    }
    
    //getter functions
    
    public func getAddress()->String{
        return self.address
    }
    
    public func getPrice()->Double{
        return self.price
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
    
    public func getContribution()->Double{
        return self.contribution
    }
    
    public func getContribution(formatted:Bool, independent: Bool = false)->String{
        if formatted {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = NumberFormatter.Style.decimal
            return "$" + numberFormatter.string(from: NSNumber(value:self.contribution / 10560))! + (independent ? "" : " invested")
        }else{
            return String(self.contribution)
        }
    }
    
    public func getID()->String{
        return self.id
    }

    
    public func getImageURL()->String{
        return self.imageURL
    }
    
}
