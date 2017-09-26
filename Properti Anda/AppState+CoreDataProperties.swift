//
//  AppState+CoreDataProperties.swift
//  Properti Anda
//
//  Created by Kendrick on 12/9/17.
//  Copyright © 2017 Kendrick. All rights reserved.
//

import Foundation
import CoreData


extension AppState {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AppState> {
        return NSFetchRequest<AppState>(entityName: "AppState")
    }

    @NSManaged public var has_loaded: Bool
    @NSManaged public var token: String?
    @NSManaged public var email: String?
    @NSManaged public var first_name: String?
    @NSManaged public var last_name: String?
    @NSManaged public var user_id: String?

}
