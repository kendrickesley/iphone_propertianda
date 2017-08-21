//
//  DrawerData.swift
//  Properti Anda
//
//  Created by Kendrick on 21/8/17.
//  Copyright © 2017 Kendrick. All rights reserved.
//

import Foundation
import UIKit
import Material

class DrawerData{
    private var data:[Drawer] = []
    init(){
        self.data.append(Drawer(title: "Home", icon: Icon.home!))
        self.data.append(Drawer(title: "Dashboard", icon: Icon.work!))
        self.data.append(Drawer(title: "Portfolio", icon: Icon.place!))
        self.data.append(Drawer(title: "Preferences", icon: Icon.settings!))
    }
    
    public func getAllData() -> [Drawer]{
        return self.data
    }
    public func getData(byIndex index: Int) -> Drawer{
        return self.data[index]
    }
}

class Drawer{
    private var title:String = ""
    private var icon:UIImage
    
    init(title:String, icon:UIImage){
        self.title = title
        self.icon = icon
    }
    
    public func getName()->String{
        return self.title
    }
    public func getIcon()->UIImage{
        return self.icon
    }
}
