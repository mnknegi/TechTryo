//
//  CDEmployee+CoreDataProperties.swift
//  core-data
//
//  Created by Mayank Negi on 09/02/24.
//
//

import Foundation
import CoreData


extension CDEmployee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDEmployee> {
        return NSFetchRequest<CDEmployee>(entityName: "CDEmployee")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var email: String?

}

extension CDEmployee : Identifiable {

}
