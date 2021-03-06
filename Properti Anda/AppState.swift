//
//  AppState.swift
//  Properti Anda
//
//  Created by Kendrick on 12/9/17.
//  Copyright © 2017 Kendrick. All rights reserved.
//

import Foundation
import CoreData
import UIKit
/*
 AppState has the following information:
 1. Email
 2. UserID
 3. Token
 4. First Name
 5. Last Name
 6. Flag if the application has loaded before / not
 */
class AppStateModel{
    static let sharedInstance = AppStateModel()
    private init(){
        managedContext = appDelegate.persistentContainer.viewContext
    }
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext: NSManagedObjectContext
    var appStateDb = [NSManagedObject]()
    
    //update the database
    func updateDatabase(){
        do{
            try managedContext.save()
        }catch let error as NSError{
            print("Error saving \(error), \(error.userInfo)")
        }
    }
    
    func saveEmail(email:String, existing:AppState){
        existing.email = email
        updateDatabase()
    }
    
    func saveUserID(userID:String, existing:AppState){
        existing.user_id = userID
        updateDatabase()
    }
    
    func saveFirstName(firstName: String, existing: AppState){
        existing.first_name = firstName
        updateDatabase()
    }
    
    func saveLastName(lastName: String, existing: AppState){
        existing.last_name = lastName
        updateDatabase()
    }
    
    func saveToken(token: String, existing: AppState){
        existing.token = token
        updateDatabase()
    }
    
    //change the flag of the first loading
    func saveHasLoaded(hasLoaded: Bool, existing: AppState){
        existing.has_loaded = hasLoaded
        updateDatabase()
    }
    
    //Save a complete auth flow
    func saveAuth(email: String, firstName: String, lastName: String, token: String, userID:String, existing: AppState){
        existing.email = email;
        existing.first_name = firstName
        existing.last_name = lastName
        existing.token = token
        existing.user_id = userID
        updateDatabase()
    }
    
    //Reset the existing data
    func clearAuth(existing: AppState){
        existing.email = ""
        existing.first_name = ""
        existing.last_name = ""
        existing.token = ""
        existing.user_id = ""
        updateDatabase()
    }
    
    //create or update the appState
    func saveAppState(email: String, firstName: String, lastName: String, token:String, hasLoaded:Bool, userID: String, existing: AppState?=nil){
        let entity = NSEntityDescription.entity(forEntityName: "AppState", in: managedContext)!
        if let _ = existing{
            existing!.first_name = firstName
            existing!.last_name = lastName
            existing!.token = token
            existing!.email = email
            existing!.has_loaded = hasLoaded
            existing!.user_id = userID
        }else{
            let appState = NSManagedObject(entity: entity, insertInto: managedContext)
            appState.setValue(firstName, forKeyPath:"first_name")
            appState.setValue(lastName, forKeyPath:"last_name")
            appState.setValue(email, forKeyPath:"email")
            appState.setValue(token, forKeyPath: "token")
            appState.setValue(token, forKeyPath: "user_id")
            appState.setValue(hasLoaded, forKeyPath: "has_loaded")
            appStateDb.append(appState)
        }
        updateDatabase()
    }
    
    func getAppStates(){
        do{
            let fetchRequest = NSFetchRequest <NSFetchRequestResult> (entityName:"AppState")
            let results = try managedContext.fetch(fetchRequest)
            appStateDb = results as! [NSManagedObject];
        }catch let error as NSError{
            print("Error fetching \(error), \(error.userInfo)")
        }
    }
    
    func getAppState () -> AppState? {
        if appStateDb.count > 0 {
            return appStateDb[0] as? AppState
        }else{
            return nil
        }
    }
    
    //delete the appstate
    func deleteAppState(_ appState: AppState){
        managedContext.delete(appState)
        updateDatabase()
    }
}
