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

class Investments{
    var investments:[Investment] = []
    
    init(investments:[Investment]){
        self.investments = investments
    }
    
    init(){
        //self.investments.append(Investment(address: "Help", price: 0, progressPrice: 0, completed: true, investors: 3, detail: "lol", imageURL: "a", id: "1", contribution: 3, status: "PENDING"))
    }
    
    public func requestInvestments(callback: @escaping () -> Any){
        let app:AppState? = AppStateModel.sharedInstance.getAppState()
        let userID:String = app?.user_id ?? ""
        let parameters: Parameters = [
            "userid": userID,
            "token": app?.token ?? "",
            "mode": "all_owned_share"
        ]
        Alamofire.request("https://propertianda.com/php/market_requester.php", method: .post, parameters:parameters).responseJSON { response in
            print("Result: \(response.result)")                         // response serialization result
            
            if let body = response.result.value {
                let json = JSON(body)
                self.parseInvestmentsJson(json: json, callback: callback)
            }
        }
    }
    
    private func parseInvestmentsJson(json: JSON, callback: ()->Any){
        print("\(json)")
        let _ = callback()
    }
    
    
    public func getAllInvestments()->[Investment]{
        return investments
    }
    public func getInvestment(byIndex:Int)->Investment{
        if byIndex < investments.count {
            return investments[byIndex]
        }else{
            return Investment(address:"Default")
        }
    }
}

class Investment{
    var address:String = ""
    var price:Double = 0
    var completed:Bool = false
    var progressPrice:Double = 0
    var investors:Int = 0
    var detail:String = ""
    var imageURL:String = ""
    var id:String = ""
    var status:String = ""
    var contribution:Double = 0
    
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
    
    convenience init(address:String, price:Double, progressPrice:Double, completed:Bool, investors:Int, detail:String, imageURL:String, id: String, contribution: Double, status: String){
        self.init(address:address, price:price, progressPrice:progressPrice, completed:completed, investors: investors, detail:detail, id: id)
        self.imageURL = imageURL
        self.contribution = contribution
        self.status = status
    }
    
    public func getContribution()->Double{
        return self.contribution
    }
    
    public func getStatus()->String{
        return self.status
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
